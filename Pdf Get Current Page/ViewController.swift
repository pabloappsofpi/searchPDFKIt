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
    var document: PDFDocument!
    var searchedItem: PDFSelection?
    let dictionaryOfBooks = ["Hamlet", "Othello"]

    @IBAction func backBook(_ sender: Any) {
        if let document = PDFDocument(url: Bundle.main.url(forResource: dictionaryOfBooks.last!, withExtension: "pdf")!) {
            
            // set the new book
            pdfView.document = document
            
        }
    }
    
    @IBOutlet weak var pageNumber: NSTextField!
    let pdfTitle = "Hamlet"

    @IBOutlet weak var textToSearch: NSTextField!
    
    @IBAction func NextBook(_ sender: Any) {
        //change book to Othello
        if let document = PDFDocument(url: Bundle.main.url(forResource: dictionaryOfBooks.first!, withExtension: "pdf")!) {
           
            // set the new book
            pdfView.document = document
    
        }
            
        }


    
    
    

        


    @IBAction func searchText(_ sender: Any) {
    let textForSearch = textToSearch.stringValue
        print(textForSearch)
        let searchResults = pdfView.document!.findString(textForSearch, from: searchedItem, with: .caseInsensitive)
       let pagesWhereFinded = searchResults?.pages
        print(pagesWhereFinded)
        pdfView.currentSelection = searchResults
        let pdfPage = pdfView.document!.page(at: 2)!
        let pdfPageToGo = pdfView.document!.page(at: pdfView.document!.index(for: pagesWhereFinded![0]))
        let cgRect = pdfView.currentSelection!.bounds(for: pdfPage)
        pdfView.go(to: cgRect, on: pdfPageToGo!)
        //pdfView.go(to: searchResults!)
        
    }
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
        if Bundle.main.url(forResource: pdfTitle, withExtension: "pdf") != nil{
            //get number of page pdf
            guard let pdf = CGPDFDocument(Bundle.main.url(forResource: pdfTitle, withExtension: "pdf")! as CFURL) else {
                print("Not able to load pdf file.")
                return
            }
            let pageCount = pdf.numberOfPages
            //pages begin with count on cero
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
        let url = Bundle.main.url(forResource: pdfTitle, withExtension: "pdf")
        document = PDFDocument(url: url!)
        pdfView.document = document
        pdfView.document?.delegate = self as? PDFDocumentDelegate

        
    }
  

    
     func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear()
        pdfView.document?.beginFindString("22", with: .caseInsensitive)
    }
    
    func documentDidEndDocumentFind(_ notification: Notification) {
        pdfView.setCurrentSelection(searchedItem, animate: true)
    }
    
    func documentDidFindMatch(_ notification: Notification) {
        if let selection = notification.userInfo?.first?.value as? PDFSelection {
            selection.color = .yellow
            if searchedItem == nil {
                // The first found item sets the object.
                searchedItem = selection
            } else {
                // All other found selection will be nested
                searchedItem!.add(selection)
            }
        }

}
}

