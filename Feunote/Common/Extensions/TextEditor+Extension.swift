//
//  TextEditor+Extension.swift
//  Feunote
//
//  Created by Losd wind on 2022/12/2.
//

import Foundation
import SwiftUI

extension TextEditor { @ViewBuilder func hideBackground() -> some View { if #available(iOS 16, *) { self.scrollContentBackground(.hidden) } else { self } } }
