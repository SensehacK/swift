import UIKit




let userCalendar = Calendar.current
 
// The Swift programming language was first released on
// June 2, 2014.
// 2
let swiftDebutDateComponents = DateComponents(
  year: 2014,
  month: 6,
  day: 2
)
 

let swiftDebutDate = userCalendar.date(from: swiftDebutDateComponents)!


print("Swift’s debut date, via the DateFormatter: \(myFormatter.string(from: swiftDebutDate))")// Let’s define the format for date strings we want to parse:


let myFormatter = DateFormatter()
myFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"


// Here's a date in the specified format.
// DateFormatter’s date(from:) method will be able to parse it.
let newDate1 = myFormatter.date(from: "2021-03-26T16:52:41Z")
print("newDate1’s value is: \(newDate1?.description ?? "nil").")

let newDate3 = myFormatter.date(from: "2021-03-26 16:52:41")
print("newDate1’s value is: \(newDate3?.description ?? "nil").")


// And here's the same date, but in a different format:
let newDate2 = myFormatter.date(from: "Jun 6, 2019, 12:08 PM PDT")
print("newDate2’s value is: \(newDate2?.description ?? "nil").")
