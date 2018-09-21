//
//  ViewController.swift
//  Pdf Get Current Page
//
//  Created by Pablo Fabre on 9/21/18.
//  Copyright © 2018 Pablo Fabre. All rights reserved.
//

import Cocoa
import Quartz.PDFKit
class ViewController: NSViewController {
    @IBOutlet weak var pageNumber: NSTextField!
    let pdfTitle = "22 laws"

    @IBAction func getCurrentPage(_ sender: Any) {
        //get current page
        let currentPage = pdfView.currentPage!
        //PDFPage
        print(type(of: currentPage))
        pageNumber.stringValue = "\(currentPage)"
    }
    @IBOutlet weak var getCurrentPage: NSButton!
    @IBOutlet weak var pdfView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdfURL = Bundle.main.url(forResource: pdfTitle, withExtension: "pdf"){
            //get number of page pdf
            guard let pdf = CGPDFDocument(Bundle.main.url(forResource: pdfTitle, withExtension: "pdf")! as CFURL) else {
                print("Not able to load pdf file.")
                return
            }
            let pageCount = pdf.numberOfPages
            
            print("page count:\(pageCount)")
        }
        else{
            print("error")
        }
        // Bundle.main.url(forResource: pdfTitle, withExtension: "pdf")
        if let document = PDFDocument(url: Bundle.main.url(forResource: pdfTitle, withExtension: "pdf")!) {

            pdfView.document = document
            
// Retrieve a page
            
            
        }
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

