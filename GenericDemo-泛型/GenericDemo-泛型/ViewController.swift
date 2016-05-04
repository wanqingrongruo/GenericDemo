//
//  ViewController.swift
//  GenericDemo-泛型
//
//  Created by 婉卿容若 on 16/5/3.
//  Copyright © 2016年 婉卿容若. All rights reserved.
//

import UIKit


//泛型结构体
struct Stack<T> {
    
    //数组---数组元素为泛型
    var items = [T]()
    
    //压栈
    mutating func push(item: T){
        items.append(item)
    }
    
    //出栈
    mutating func pop(){
        if !items.isEmpty {
            items.removeLast()
        }
    
    }
    
}

//继承约束
//定义父类
class Animal{
    
    func eat() -> Void {
        print("Animal eat")
    }
}
//定义子类
class Dog:Animal{
    
    override func eat(){
        print("Dog eat_______")
    }
}
class Cat: Animal {
    override func eat() {
        print("Cat eat~~~~~~~~")
    }
}


//定义一个泛型协议,和其他泛型使用方式不同,这里泛型是以关联类型形式使用的
protocol Stackable{
    //声明一个关联类型,使用associatedtype关键字
    associatedtype ItemType
    
    mutating func push(item: ItemType)
    mutating func pop() -> ItemType?
}

struct stackExm<T>:Stackable {
    //数组---数组元素为泛型
    var items = [T]()
    
    //压栈---实现协议的push方法
    mutating func push(item: T){
        items.append(item)
    }
    
    //出栈---实现协议的pop方法
    mutating func pop() -> T?{
        if !items.isEmpty {
           return items.removeLast()
        }else{
            return nil
        }
        
    }

}

//常见另一个结构体,同样实现Stackable协议
struct stackExm02<T>:Stackable {
    //数组---数组元素为泛型
    var items = [T]()
    
    //压栈---实现协议的push方法
    mutating func push(item: T){
        items.append(item)
    }
    
    //出栈---实现协议的pop方法
    mutating func pop() -> T?{
        if !items.isEmpty {
            return items.removeLast()
        }else{
            return nil
        }
        
    }
    
}

class ViewController: UIViewController {
    
    var resultArray = [Int]()
    var resu2 = ["演员","雅俗共赏"]
    
    lazy var temp01:[String] = { () -> [String] in
        
        return ["你那么爱他","请联络我"]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
        //1.泛型基本使用--->泛型函数(函数参数或返回值类型用泛型表示)
        appendToArray([1,2,3], resultArray: &resultArray)
        print("resultArray:\(resultArray)")
        appendToArray(temp01, resultArray: &resu2)
        print("resu2:\(resu2)")
        
        //2.泛型在结构体中的使用->泛型类型(定义类型时使用泛型)
        //---泛型可以使用在类/结构体/枚举等各种类型
        var stackOfString = Stack<String>()
        stackOfString.push("不是说要放下所有一切吗?")
        stackOfString.push("你却来到这十字路口")
        print(stackOfString.items)
        print("出栈:\(stackOfString.pop())")
        print(stackOfString.items)
        
        //3.泛型约束
        /*
         /*3.1 继承约束,泛型类型必须是某个类的子类类型
         使用格式:
         func 函数名<泛型:继承父类>(参数列表) -> 返回值{//函数体}
          */
         
         /*3.2 协议约束,泛型类型必须遵循某些协议
         使用格式:
         func 函数名<泛型:协议>(参数列表) -> 返回值{//函数体}
         */
         
         /*3.3 条件约束,泛型类型必须满足某种条件
         使用格式:
         func 函数名<泛型1,泛型2 where 条件>(参数列表) -> 返回值{//函数体}
         */
         
         */
        
        //3.1
        AnimalRunEat(Dog())
        
        //3.2 协议
        let doubleIndex = findIndex([1,3.333,555,6.55], valueToFind: 99)
        if  let index = doubleIndex {
            print("在浮点数组中找到99,索引为\(index)")
        }else{
            print("在浮点数组中寻找不到99")
        }
        
        //3.3 泛型协议+条件
        var stackOne = stackExm<String>()
        stackOne.push("Hello")
        stackOne.push("Swift")
        stackOne.push("World")
        
        if let t = stackOne.pop() {
            print("t = \(t)")
        }
        
        var stackTwo = stackExm02<String>()
        stackTwo.push("where")
        //虽然stackOne和stackTwo类型不一样，但泛型类型一样，也同样遵循了Stackable协议
        pushItemOneToTwo(&stackOne, stackTwo: &stackTwo)
        print("stackOne = \(stackOne.items), stackTwo = \(stackTwo.items)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.  
    }


}


// MARK: - 向数组添加元素---数组中元素可以是任何类型

extension ViewController{
    
    //T类型占用符--可以表示任意类型
    /**
     向泛型数组中添加数据元素
     
     
     - parameter tempArray:   原数组
     - parameter resultArray: 变化数组
     */
    func appendToArray<T>(tempArray: [T], inout resultArray: [T]) -> Void {
        for element in tempArray {
            resultArray.append(element)
        }
    }
    
}

// MARK: - 泛型约束

extension ViewController{
    
    //定义泛型函数,接受一个泛型参数
    
    func AnimalRunEat<T: Animal>(animal: T) -> Void {
        animal.eat()
    }
    
    //定义泛型函数,为泛型添加协议约束,泛型类型必须遵循Equatable协议
    //该协议要求任何遵循的类型实现等式符(==)和不等符(!=)对任何两个该类型进行比较。所有的Swift标准类型自动支持Equatable协议。
    func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
        var index = 0
        
        for value in array {
            if value == valueToFind {
                return index
            }else{
                index += 1
            }
        }
        
        return nil
    }
    
    //添加泛型条件约束,C1和C2必须遵循stackable协议,而且C1和C2包含的泛型类型要一致
    func pushItemOneToTwo<C1: Stackable, C2: Stackable where C1.ItemType == C2.ItemType >(inout stackOne: C1, inout stackTwo: C2) -> Void {
        if let item = stackOne.pop() {
            stackTwo.push(item)

        }
    }
}

