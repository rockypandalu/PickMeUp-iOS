//
//  DDBDriver.swift
//  PickMeUp
//
//  Created by Yan Lu on 16/5/5.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

class DDBDriver :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var username_time:String?;
    var location:String?
    var time:String?
    var Time:String?
    var username:String?
    class func dynamoDBTableName() -> String! {
        return "ClientBooking"
    }
    
    
    // if we define attribute it must be included when calling it in function testing...
    class func hashKeyAttribute() -> String! {
        return "ID"
    }
    
    
    
    class func ignoreAttributes() -> Array<AnyObject>! {
        return []
    }
    
    //MARK: NSObjectProtocol hack
    //Fixes Does not conform to the NSObjectProtocol error
    
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
}
