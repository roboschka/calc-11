//
//  ViewController.swift
//  Calculator
//
//  Created by Maria Jeffina on 28/02/20.
//  Copyright © 2020 Maria Jeffina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation? //bisa aja kita belom punya operation
    
    enum Operation {
        case add, substract, multiply, divide
    }
    private var resultLabel: UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }
    
    private func setupNumberPad(){
        let buttonSize : CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        holder.addSubview(zeroButton)
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        for x in 0..<3 { //looping selama 0 1 2 (3x)
            let button1 = UIButton(frame: CGRect(x: buttonSize * (CGFloat(x)), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            holder.addSubview(button1)
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            button1.tag = x+2
        }
        
        //buttonSize typenya CGFloat, dan harus dikali dengan x for yang modelnya CGFLoat juga. Tapi x CGRect yang nerima juga harus CGFloat tipenya.
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * (CGFloat(x)), y: holder.frame.size.height - (buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            holder.addSubview(button2)
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            button2.tag = x+5
        }
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize*(CGFloat(x)), y: holder.frame.size.height - (buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.setTitle("\(x+7)", for: .normal)
            button3.backgroundColor = .white
            holder.addSubview(button3)
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            button3.tag = x+8
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize*5), width: buttonSize*3, height: buttonSize))
        clearButton.setTitle("CLEAR", for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitleColor(.black, for: .normal)
        holder.addSubview(clearButton) //dirender ke layar
        
        //--OPERATION BUTTONS--
        let operations = ["=","+", "-", "*", "/"]
        for x in 0..<5 {
            let opButton = UIButton(frame: CGRect(x: buttonSize*3, y: (holder.frame.size.height - (buttonSize)) - (buttonSize*CGFloat(x)), width: buttonSize, height: buttonSize))
            opButton.setTitle(operations[x], for: .normal)
            opButton.setTitleColor(.white, for: .normal)
            opButton.backgroundColor = .orange
            opButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            holder.addSubview(opButton)
            opButton.tag = x+1
            
        }
        
//        let eqButton = UIButton(frame: CGRect(x: buttonSize*3, y: holder.frame.size.height - buttonSize, width: buttonSize, height: buttonSize))
//        eqButton.setTitleColor(.white, for: .normal)
//        eqButton.setTitle("=", for: .normal)
//        eqButton.backgroundColor = .orange
//        holder.addSubview(eqButton)
//        eqButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        
        //--LABEL RESULT--
        resultLabel.frame = CGRect(x: 10, y: holder.frame.size.height - (buttonSize * 6), width: holder.frame.size.width - 30, height: 100)
        holder.addSubview(resultLabel)
        
        
        // ACTION
        clearButton.addTarget(self, action: #selector(ClearResult), for: .touchUpInside)
    }
    
    @objc func ClearResult(){
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
    }
    
    @objc func zeroTapped(){
        //satu button ga butuh kasih tau sendernya siapa
        if resultLabel.text != "0"{
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
            
        }
    }
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        if tag == 1{
            //currentOperations = .equal
            //kita harus check ketika di equal, currentOperations punya case yang mana
            if let operation = currentOperations {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .substract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                default:
                    return
                }
            }
            
        }
        else if tag == 2{
            currentOperations = .add
        }
        else if tag == 3{
            currentOperations = .substract
        }
        else if tag == 4{
            currentOperations = .multiply
        }
        else if tag == 5{
            currentOperations = .divide
        }
    }

}

