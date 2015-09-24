//
//  GMTDate.swift
//  MedControl
//
//  Created by aluno on 22/09/15.
//  Copyright (c) 2015 Puc-CCE. All rights reserved.
//

import Foundation
//: Playground - noun: a place where people can play

// Copiei estas extensões porque achei muito ruim a sintaxe normal do Swift. Exemplos para nosso uso lá no final. Ab Fábio

// Date/time overloads and extensions Swift playground
// by Joey deVilla - August 2015
// Partially based on Axel Schlueter's SwiftDateTimeExtensions library
// (https://github.com/schluete/SwiftDateTimeExtensions)
//
// Released under the MIT License (MIT)
// (c) 2015 Joey deVilla


import UIKit

let userCalendar = NSCalendar.currentCalendar()

// Let's create some dates to work with
// ====================================

// If you need to instantiate a number of pre-defined dates,
// an NSDateFormatter will get it done in the fewest number of lines.
let dateMaker = NSDateFormatter()
//dateMaker.dateFormat = "yyyy/MM/dd hh:mm:ss Z"

// I'm setting these dates according to my time zone (UTC-0500);
// feel free to adjust the values according to your time zone.
let valentinesDay = dateMaker.dateFromString("2015/02/14 00:00:00 -05:00")!
let stPatricksDay = dateMaker.dateFromString("2015/03/17 00:00:00 -05:00")!


// Comparing dates, part 1
// =======================


// Let's overload the <, >, and == operators to do date comparisons
// ----------------------------------------------------------------

func ==(lhs: NSDate, rhs: NSDate) -> Bool
{
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

func <(lhs: NSDate, rhs: NSDate) -> Bool
{
    return lhs.compare(rhs) == .OrderedAscending
}

func >(lhs: NSDate, rhs: NSDate) -> Bool
{
    return lhs.compare(rhs) == .OrderedDescending
}

// Comparisons are less clunky now!
// --------------------------------

// valentinesDay < stPatricksDay   // true
// valentinesDay == valentinesDay  // true
// stPatricksDay > valentinesDay   // true


// Comparing dates, part 2
// =======================

// Let's create two dates that are only one second apart:
//let groundhogDay = dateMaker.dateFromString("2015/02/02 00:00:00 -05:00")!
//let groundhogDayPlus1Second = dateMaker.dateFromString("2015/02/02 00:00:01 -05:00")!

// This line returns false:
// groundhogDay == groundhogDayPlus1Second
// This line returns true:
// groundhogDay < groundhogDayPlus1Second
// NSDate's compare method is too precise for a lot of uses!

// Enter NSCalendar's compareDate method, available in iOS 8 and later


// This returns true, because 2015/02/02 00:00:00 and 2015/02/02 00:00:01
// ARE both within the same HOUR.
//userCalendar.compareDate(groundhogDay,
  //  toDate: groundhogDayPlus1Second,
    //toUnitGranularity: .Hour)
    //== .OrderedSame

// Date arithmetic
// ===============


// The neat way
// ------------

// First, we define methods that allow us to add and subtract
// NSDateComponents instances

// The addition and subtraction code is nearly the same,
// so we've factored it out into this method
func combineComponents(lhs: NSDateComponents,
    rhs: NSDateComponents,
    _ multiplier: Int = 1)
    -> NSDateComponents
{
    let result = NSDateComponents()
    let undefined = Int(NSDateComponentUndefined)
    
    result.second = ((lhs.second != undefined ? lhs.second : 0) +
        (rhs.second != undefined ? rhs.second : 0) * multiplier)
    result.minute = ((lhs.minute != undefined ? lhs.minute : 0) +
        (rhs.minute != undefined ? rhs.minute : 0) * multiplier)
    result.hour = ((lhs.hour != undefined ? lhs.hour : 0) +
        (rhs.hour != undefined ? rhs.hour : 0) * multiplier)
    result.day = ((lhs.day != undefined ? lhs.day : 0) +
        (rhs.day != undefined ? rhs.day : 0) * multiplier)
    result.month = ((lhs.month != undefined ? lhs.month : 0) +
        (rhs.month != undefined ? rhs.month : 0) * multiplier)
    result.year = ((lhs.year != undefined ? lhs.year : 0) +
        (rhs.year != undefined ? rhs.year : 0) * multiplier)
    return result
}

// With combineComponents defined,
// overloading + and - is simple

func +(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents
{
    return combineComponents(lhs, rhs: rhs)
}

func -(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents
{
    return combineComponents(lhs, rhs: rhs, -1)
}

// We'll need to overload unary - so we can negate components
prefix func -(components: NSDateComponents) -> NSDateComponents {
    let result = NSDateComponents()
    let undefined = Int(NSDateComponentUndefined)
    
    if(components.second != undefined) { result.second = -components.second }
    if(components.minute != undefined) { result.minute = -components.minute }
    if(components.hour != undefined) { result.hour = -components.hour }
    if(components.day != undefined) { result.day = -components.day }
    if(components.month != undefined) { result.month = -components.month }
    if(components.year != undefined) { result.year = -components.year }
    return result
}

// Next, we extend Int to bring some Ruby-like magic
// to date components

extension Int {
    
    var seconds: NSDateComponents {
        let components = NSDateComponents()
        components.second = self;
        return components
    }
    
    var second: NSDateComponents {
        return self.seconds
    }
    
    var minutes: NSDateComponents {
        let components = NSDateComponents()
        components.minute = self;
        return components
    }
    
    var minute: NSDateComponents {
        return self.minutes
    }
    
    var hours: NSDateComponents {
        let components = NSDateComponents()
        components.hour = self;
        return components
    }
    
    var hour: NSDateComponents {
        return self.hours
    }
    
    var days: NSDateComponents {
        let components = NSDateComponents()
        components.day = self;
        return components
    }
    
    var day: NSDateComponents {
        return self.days
    }
    
    var weeks: NSDateComponents {
        let components = NSDateComponents()
        components.day = 7 * self;
        return components
    }
    
    var week: NSDateComponents {
        return self.weeks
    }
    
    var months: NSDateComponents {
        let components = NSDateComponents()
        components.month = self;
        return components
    }
    
    var month: NSDateComponents {
        return self.months
    }
    
    var years: NSDateComponents {
        let components = NSDateComponents()
        components.year = self;
        return components
    }
    
    var year: NSDateComponents {
        return self.years
    }
    
}


// Building an NSDateComponents instance that represents
// a time interval is now a lot nicer:
let newTimeInterval = 1.month + 8.days + 6.hours + 17.minutes
// Let's confirm that it works
//newTimeInterval.month   // 1
//newTimeInterval.day     // 8
//newTimeInterval.hour    // 6
//newTimeInterval.minute  // 17


// Let's make it easy to add dates and components,
// and subtract components from dates

// Date + component
func +(lhs: NSDate, rhs: NSDateComponents) -> NSDate
{
    return NSCalendar.currentCalendar().dateByAddingComponents(rhs,
        toDate: lhs,
        options: [])!
}

// Component + date
func +(lhs: NSDateComponents, rhs: NSDate) -> NSDate
{
    return rhs + lhs
}

// Date - component
// (Component - date doesn't make sense)
func -(lhs: NSDate, rhs: NSDateComponents) -> NSDate
{
    return lhs + (-rhs)
}

// Look at how easy date arithmetic is now:

// What's the date and time 2 weeks, 1 day, 13 hours, and 57 minutes
// after Groundhog Day 2015?
//groundhogDay + 2.weeks + 1.day + 13.hours + 57.minutes
// (Answer: February 17, 2015, 1:57 p.m.)

// Adding dates to date components is quite flexible:
//2.weeks + 1.day + 13.hours + 57.minutes + groundhogDay
//2.weeks + 1.day + groundhogDay + 13.hours + 57.minutes

// What was the date 1 year, 2 months, and 12 days
// prior to Groundhog Day 2015?
//groundhogDay - 1.year - 2.months - 12.days
/// (Answer: November 20, 2013)


// And finally some Ruby on Rails magic, that allows us to create dates
// with code like "2.days.fromNow" and "2.days.ago"

extension NSDateComponents {
    
    var fromNow: NSDate {
        let currentCalendar = NSCalendar.currentCalendar()
        return currentCalendar.dateByAddingComponents(self,
            toDate: NSDate(),
            options: [])!
    }
    
    var ago: NSDate {
        let currentCalendar = NSCalendar.currentCalendar()
        return currentCalendar.dateByAddingComponents(-self,
            toDate: NSDate(),
            options: [])!
    }
    
}

// Let's test the Rails magic!
// (It's August 26, 2015, 23:06 as I execute this code)

// August 28, 2015, 11:06 p.m.
//2.days.fromNow
// August 29, 2015, 2:23 a.m.
//(2.days + 3.hours + 17.minutes).fromNow
// August 24, 2015, 11:06 p.m.
//2.days.ago
// August 24, 2015, 7:49 p.m.
//(2.days + 3.hours + 17.minutes).ago

//MARK: COMEÇA AQUI  O MEDCONTROL

let natal = dateMaker.dateFromString("2015/12/25 00:00:00 -02:00")!


// todas as datas são armazenadas internamente como segundos GMT a partir do início do milênio, então lidar com time zones é o menor dos problemas.

var agora = NSDate()

var próximadose = agora + 12.hours
var últimadose = próximadose + 2.weeks + 1.day + 13.hours + 57.minutes

// No playground o if abaixo funciona mas está dando um erro, comentei

//if (últimadose > próximadose)  {
  //  print ("tudo derto")
//}












