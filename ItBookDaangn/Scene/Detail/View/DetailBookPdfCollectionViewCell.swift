//
//  DetailBookPdfCollectionViewCell.swift
//  ItBookDaangn
//
//  Created by Kim Do hyung on 3/18/24.
//

import UIKit
import PDFKit

/**
 상세화면 collectionView의 pdf를 보여주기 위한 Cell
 
 - Note: Delegate 패턴 통해 챕터 선택 alert 띄우는 책임을 ViewController에게 위임
 - Date: 2023. 03. 18
 - Authors: 김도형
 */

/// PDF 챕터 선택 Delegate
protocol PDFCollectionViewCellDelegate: AnyObject {
    func pdfCellDidSelectChapter(_ cell: DetailBookPdfCollectionViewCell)
}

final class DetailBookPdfCollectionViewCell: UICollectionViewCell {
    weak var delegate: PDFCollectionViewCellDelegate?
    
    private lazy var pdfView: PDFView = {
        let view = PDFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoScales = true
        return view
    }()
    
    private lazy var selectChapterButton: UIButton = {
        let button = UIButton()
        let buttonTitle = "챕터 선택"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.orange, for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(selectChapterAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .orange
        return indicatorView
    }()
    
    private var chapterPdfUrls: [String: URL] = [:] // 예제 URL 데이터

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func selectChapterAction() {
        delegate?.pdfCellDidSelectChapter(self)
    }

    func loadPDF(from url: URL) {
        indicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let document = PDFDocument(url: url)
            DispatchQueue.main.async { [weak self] in
                self?.pdfView.document = document
                self?.indicator.stopAnimating()
            }
        }
    }
}

//MARK: - SetupUI
extension DetailBookPdfCollectionViewCell {
    private func setupUI() {
        buildHierarchy()
        setupConstraints()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(pdfView)
        contentView.addSubview(selectChapterButton)
        contentView.addSubview(indicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //pdfView Constraint
            pdfView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pdfView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pdfView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            //selectChapterButton Constraint
            selectChapterButton.heightAnchor.constraint(equalToConstant: 44),
            selectChapterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            selectChapterButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            //indicator Constraint
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
