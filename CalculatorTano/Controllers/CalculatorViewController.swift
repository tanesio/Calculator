//
//  ViewController.swift
//  CalculatorTano
//
//  Created by Admin on 2/1/21.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: IBOutlets
    // Result

    @IBOutlet weak var resultLabel: UILabel!
    
    // Numbers
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    //Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorSubstraction: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    // MARK: - Variables
    private var total: Double = 0                   // Total
    private var temp: Double = 0                    // Valor por pantalla
    private var operating = false                   // Indicar si se ha seleccionado un operador
    private var decimal = false                     // Indicar si el valor es decimal
    private var operation: OperationType = .none    // Operacion actual
    
    // MARK: - Constantes
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kMaxValue: Double = 999999999
    private let kMinValue: Double = 0.00000001
    
    private enum OperationType {
        case none, addiction, substraction, multiplication, division, percent
    }
    
    // Formateo de valores auxiliares
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        return formatter
    }()
        
    // Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
//        numberDecimal.setTitle(kDecimalSeparator, for .normal)
//        numberDecimal.setupUI(kDecimalSeparator, for .normal)
        result()
    }
    
    
    deinit {
        print("")
    }
    
    //  MARK: - UI
    func setupUI() {
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        operatorAC.round()
        operatorPlusMinus.round()
        operatorPercent.round()
        operatorResult.round()
        operatorAddition.round()
        operatorSubstraction.round()
        operatorMultiplication.round()
        operatorDivision.round()
    }
    
    // MARK: - Operation Helper
    
    private func sendOperation(operation: OperationType) {
        if operation != .percent {
            result()
        }
        operating = true
        self.operation = operation
        if operation == .percent {
            result()
        }
    }
    
    
    // MARK: - Button Actions
    @IBAction func operatorACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }
    @IBAction func operatorPercentAction(_ sender: UIButton) {
//        if operation != .percent {
//            result()
//        }
//        operating = true
//        operation = .percent
//        result()
        
        sendOperation(operation: .percent)
        sender.shine()
    }
    @IBAction func operatorResultAction(_ sender: UIButton) {
        result()
        sender.shine()
    }
    @IBAction func opertorAdditionAction(_ sender: UIButton) {
//        result()
//        operating = true
//        operation = .addiction
        
        sendOperation(operation: .addiction)
        sender.shine()
    }
    @IBAction func operatorSubstraction(_ sender: UIButton) {
//        result()
//        operating = true
//        operation = .substraction
        
        sendOperation(operation: .substraction)
        sender.shine()
    }
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
//        result()
//        operating = true
//        operation = .multiplication
        
        sendOperation(operation: .multiplication)
        sender.shine()
    }
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
//        result()
//        operating = true
//        operation = .division
        
        sendOperation(operation: .division)
        sender.shine()
    }
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        let currentTemp = auxFormatter.string(from: NSNumber(value: temp))
        if !operating && currentTemp!.count >= kMaxLength {
            return
        }
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        decimal = true
        
        
        sender.shine()
    }
    @IBAction func numberAction(_ sender: UIButton) {
        
        numberAction(value: sender.tag)
        
        sender.shine()
    }
    
    func numberAction(value: Int) {
        
        //LOGICA
        
        operatorAC.setTitle("C", for: .normal)
        print("temp \(temp)")
        let number = NSNumber(value: temp)
        
        print("number \(number)")
        
        guard let numberX = auxFormatter.string(from: number) else {
            
            print("fallo numberX")
            return
        }
        
        print("numberX \(numberX)")
        
        
        var currentTemp:String = auxFormatter.string(from: number) ?? ""
        
        print("currentTemp \(String(describing: currentTemp))")
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        // Hemos seleccionado una operacion
        if operating {
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currentTemp = ""
            operating = false
        }
        // Hemos seleccionado decimal
        if decimal {
            currentTemp = "\(String(describing: currentTemp))\(kDecimalSeparator)"
//            currentTemp = currentTemp ?? "0.0" + kDecimalSeparator
            decimal = false
        }
//        temp = Double(Double(currentTemp) + Double(value))
        temp = Double(currentTemp + String(value))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        //LOGICA
    }
    
    // Limpia valores
    private func clear() {
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
        }
    }
    
    // Obtiene el resultado final
    private func result() {
            
        switch operation {
        
        case .none:
            // NO se hace nada
            break
        case .addiction:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        // Formateo en pantalla
        if total <= kMaxValue || total >= kMinValue {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        print("TOTAL: \(total)")
    }
}
