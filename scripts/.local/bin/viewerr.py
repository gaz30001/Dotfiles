#!/usr/bin/env python3
import sys
import os
from PyQt5.QtWidgets import (QApplication, QMainWindow, QLabel, QFileDialog, QListWidget, QListWidgetItem,
                             QHBoxLayout, QWidget)
from PyQt5.QtGui import QPixmap, QImageReader, QIcon, QFont, QPainter, QColor
from PyQt5.QtCore import Qt, QSize
from PyQt5.QtSvg import QSvgRenderer

class ImageViewer(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Image Viewer")
        self.setStyleSheet("background-color: #171717;")

        self.label = QLabel()
        self.label.setAlignment(Qt.AlignCenter)
        self.label.setStyleSheet("background-color: #171717;")

        self.file_label = QLabel()
        self.file_label.setStyleSheet("color: black; font-size: 12px;")
        self.file_label.setAlignment(Qt.AlignRight | Qt.AlignBottom)
        self.file_label.setMargin(5)

        self.thumbnail_list = QListWidget()
        self.thumbnail_list.setViewMode(QListWidget.IconMode)
        self.thumbnail_list.setIconSize(QSize(100, 100))
        self.thumbnail_list.setFixedWidth(110)
        self.thumbnail_list.setSpacing(2)
        self.thumbnail_list.setStyleSheet("background-color: #171717; border: none;")
        self.thumbnail_list.setFocusPolicy(Qt.NoFocus)
        self.thumbnail_list.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.thumbnail_list.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.thumbnail_list.itemClicked.connect(self.thumbnail_clicked)

        self.thumbnail_visible = True

        self.layout = QHBoxLayout()
        self.layout.addWidget(self.thumbnail_list)
        self.layout.addWidget(self.label)

        container = QWidget()
        container.setLayout(self.layout)
        self.setCentralWidget(container)
        self.statusBar().addPermanentWidget(self.file_label, 1)

        self.image_files = []
        self.current_index = 0
        self.scale_factor = 1.0

        if len(sys.argv) > 1:
            self.load_folder(os.path.dirname(sys.argv[1]))
            self.open_image(sys.argv[1])
        else:
            folder = QFileDialog.getExistingDirectory(self, "Выберите папку с изображениями")
            if folder:
                self.load_folder(folder)
                if self.image_files:
                    self.open_image(self.image_files[0])

    def load_folder(self, folder):
        supported_formats = QImageReader.supportedImageFormats()
        supported_extensions = [str(fmt, 'utf-8').lower() for fmt in supported_formats] + ['svg']
        self.image_files = [os.path.join(folder, f) for f in sorted(os.listdir(folder))
                            if f.lower().split('.')[-1] in supported_extensions]
        self.thumbnail_list.clear()
        for img in self.image_files:
            if img.lower().endswith('.svg'):
                svg = QSvgRenderer(img)
                pixmap = QPixmap(100, 100)
                pixmap.fill(Qt.transparent)
                painter = QPainter(pixmap)
                svg.render(painter)
                painter.end()
            else:
                pixmap = QPixmap(img).scaled(100, 100, Qt.KeepAspectRatio, Qt.SmoothTransformation)
            item = QListWidgetItem(QIcon(pixmap), "")
            item.setData(Qt.UserRole, img)
            self.thumbnail_list.addItem(item)

    def open_image(self, path):
        self.current_index = self.image_files.index(path)
        self.update_image()
        self.highlight_thumbnail()

    def update_image(self):
        path = self.image_files[self.current_index]
        if path.lower().endswith('.svg'):
            svg = QSvgRenderer(path)
            pixmap = QPixmap(800, 600)
            pixmap.fill(Qt.transparent)
            painter = QPainter(pixmap)
            svg.render(painter)
            painter.end()
            image = pixmap
        else:
            image = QPixmap(path)

        scaled = image.scaled(int(image.width() * self.scale_factor),
                              int(image.height() * self.scale_factor),
                              Qt.KeepAspectRatio,
                              Qt.SmoothTransformation)
        self.label.setPixmap(scaled)
        self.file_label.setText(os.path.basename(path))
        self.label.repaint()

    def highlight_thumbnail(self):
        for i in range(self.thumbnail_list.count()):
            item = self.thumbnail_list.item(i)
            if i == self.current_index:
                item.setBackground(QColor("#B8BB26"))
            else:
                item.setBackground(Qt.transparent)
        self.thumbnail_list.setCurrentRow(self.current_index)
        self.thumbnail_list.scrollToItem(self.thumbnail_list.item(self.current_index))

    def keyPressEvent(self, event):
        if event.key() == Qt.Key_Right or event.key() == Qt.Key_Space:
            self.current_index = (self.current_index + 1) % len(self.image_files)
            self.update_image()
            self.highlight_thumbnail()
        elif event.key() == Qt.Key_Left:
            self.current_index = (self.current_index - 1) % len(self.image_files)
            self.update_image()
            self.highlight_thumbnail()
        elif event.key() == Qt.Key_Up:
            self.scale_factor += 0.1
            self.update_image()
        elif event.key() == Qt.Key_Down:
            self.scale_factor = max(0.1, self.scale_factor - 0.1)
            self.update_image()
        elif event.key() == Qt.Key_T:
            self.thumbnail_visible = not self.thumbnail_visible
            self.thumbnail_list.setVisible(self.thumbnail_visible)

    def thumbnail_clicked(self, item):
        path = item.data(Qt.UserRole)
        self.current_index = self.image_files.index(path)
        self.update_image()
        self.highlight_thumbnail()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    viewer = ImageViewer()
    viewer.show()
    sys.exit(app.exec_())

