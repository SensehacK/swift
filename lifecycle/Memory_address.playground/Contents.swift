import UIKit
import Foundation

func CoW_Sequence() {
    let array1 = [1,2,3]
    var array2 = array1
    print("Before Changing / Mutating data | Value type")
    array1.withUnsafeBufferPointer { (point) in
        print("Array1 Address \(point)")
    }
    array2.withUnsafeBufferPointer { (point) in
        print("Array2 Address \(point)")
    }


    print("******************************")
    print("After Changing / Mutating data | Value type")
    array2[2] = 8
    array1.withUnsafeBufferPointer { (point) in
        print("Array1 Address \(point)")
    }
    array2.withUnsafeBufferPointer { (point) in
        print("Array2 Address \(point)")
        
    }
}


struct CustomType {
    let name = "Hello"
    var age = 17
}

func CoW_Structs() {
    
    var firstObject: CustomType = CustomType()
    var secondObject: CustomType = firstObject
//    firstObject.age = 23
    
    withUnsafePointer(to: firstObject) { print("First variable  \($0)") }
    withUnsafePointer(to: secondObject) { print("Second variable \($0)") }
//    print(Unmanaged.passUnretained(firstObject).toOpaque())
//    print(Unmanaged.passUnretained(secondObject).toOpaque())
//    firstObject.age = 23
    print(firstObject.age)
    print(secondObject.age)
    
//    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//        secondObject.age = 77
//        print(secondObject.age)
//        withUnsafePointer(to: secondObject) { print("secondObject mutation:  \($0)") }
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//        withUnsafePointer(to: firstObject) { print("First variable  \($0)") }
//    }
//    DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//        secondObject.age = 89
//        print(secondObject.age)
//        withUnsafePointer(to: secondObject) { print("Second variable \($0)") }
//    }

    DispatchQueue.main.asyncAfter(deadline: .now()+10) {
        withUnsafePointer(to: firstObject) { print("First variable  \($0)") }
    }

    DispatchQueue.main.asyncAfter(deadline: .now()+10) {
        withUnsafePointer(to: secondObject) { print("Second variable \($0)") }
    }

}


//CoW_Structs()

CoW_Sequence()
