//
//  MTMContactsManager.m
//  MTMContactsManager
//
//  Created by Emanuele on 18/11/2014.
//  Copyright (c) 2014 manupeco. All rights reserved.
//

#import "MTMContactsManager.h"
#import "MTMContact.h"

@import AddressBook;

@implementation MTMContactsManager

+(NSArray *)getAllContacts
{
    
    CFErrorRef *error = nil;
    
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted) {
        
#ifdef DEBUG
        NSLog(@"Fetching contact info ----> ");
#endif
        
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        // Use nil as second parameter to retrieve all people. See http://stackoverflow.com/questions/24618171/abaddressbook-crash-cfstringref
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, nil, kABPersonSortByFirstName);
        CFIndex nPeople = CFArrayGetCount(allPeople);
        NSMutableArray* items = [NSMutableArray arrayWithCapacity:nPeople];
        
        
        for (int i = 0; i < nPeople; i++)
        {
            MTMContact *contact = [MTMContact new];
            
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            
            //get First Name and Last Name
            
            contact.firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            
            contact.lastName =  (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
            
            if (!contact.firstName) {
                contact.firstName = @"";
            }
            if (!contact.lastName) {
                contact.lastName = @"";
            }
            
            // get contacts picture, if pic doesn't exists, show standart one
            
//            NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(person);
//            contact.image = [UIImage imageWithData:imgData];
//            if (!contact.image) {
//                contact.image = nil;
//            }
            
            //get Phone Numbers
            
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            
            ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            for(CFIndex i=0;i<ABMultiValueGetCount(multiPhones);i++) {
                
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                NSString *phoneNumber = (__bridge NSString *) phoneNumberRef;
                [phoneNumbers addObject:phoneNumber];
                
                //NSLog(@"All numbers %@", phoneNumbers);
                
            }
            
            
            [contact setPhones:phoneNumbers];
            
            //get Contact email
            
            NSMutableArray *contactEmails = [NSMutableArray new];
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++) {
                CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                NSString *contactEmail = (__bridge NSString *)contactEmailRef;
                
                [contactEmails addObject:contactEmail];
                // NSLog(@"All emails are:%@", contactEmails);
                
            }
            
            [contact setEmails:contactEmails];
            
            
            
            [items addObject:contact];
            
#ifdef DEBUG
            //NSLog(@"Person is: %@", contacts.firstNames);
            //NSLog(@"Phones are: %@", contacts.numbers);
            //NSLog(@"Email is:%@", contacts.emails);
#endif
            
            
            
            
        }
        return items;
        
        
        
    } else {
#ifdef DEBUG
        NSLog(@"Cannot fetch Contacts :( ");        
#endif
        return nil;
        
        
    }
    
}
@end
