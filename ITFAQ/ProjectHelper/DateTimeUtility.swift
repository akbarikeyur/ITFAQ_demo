//
//  DateTimeUtility.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation

//MARK: - DATE_FORMATE
enum DATE_FORMATE : String{
    case DATE_TIME = "yyyy-MM-dd'T'HH:mm:ss"
    case DATE = "dd-MM-yyyy"
    case DATE1 = "yyyy-MM-dd"
    case TIME = "hh:mm a"
    case DAY = "dd"
    case MONTH = "MM"
    case MONTH_SHORT = "MMM"
    case MONTH_FULL = "MMMM"
    case YEAR = "yyyy"
    case APPOINTMENT_DATE = "dd-MMM-yyyy"
    case DATE_TIME_S = "yyyy-MM-dd'T'HH:mm:ss.S"
    case DATE_TIME_REPLY = "MM/dd/yyyy hh:mm:ss a"
    case DATE_S = "yyyy-MM-dd HH:mm:ss.S"
    
    func getValue() ->String {
        return self.rawValue
    }
}

func getTimestampFromDate(date : Date) -> Double
{
    return date.timeIntervalSince1970
}

func getDateFromTimeStamp(_ timeStemp:Double) -> Date
{
    return Date(timeIntervalSince1970: TimeInterval(timeStemp/1000))
}

func getLocalStringFromUTCDate(_ date : Date, _ outFormat : String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = outFormat
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter.string(from: date)
}

func getLocalDateFromUTCString(_ strDate : String, _ inFormat : String, _ outFormat : String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let dt = dateFormatter.date(from: strDate)
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = outFormat
    let date1 : String = dateFormatter.string(from: dt ?? Date())
    return dateFormatter.date(from: date1)!
}

extension String {
  //MARK:- Convert UTC To Local Date by passing date formats value
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        return dateFormatter.string(from: dt ?? Date())
    }
    
  //MARK:- Convert Local To UTC Date by passing date formats value
    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        return dateFormatter.string(from: dt ?? Date())
    }
    
    func StringToString(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone.current
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        return dateFormatter.string(from: dt ?? Date())
    }
}
