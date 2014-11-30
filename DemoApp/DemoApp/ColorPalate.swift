//
//  ColorPalate.swift
//  DemoApp
//
//  Created by Shengzhe Chen on 11/29/14.
//  Copyright (c) 2014 Shengzhe Chen. All rights reserved.
//

import Foundation
import UIKit

enum ColorPalate
{
    case LightFuji, Fuji, SemiFuji, DarkFuji
    case LightBamboo, Bamboo, SemiBamboo, DarkBamboo
    case LightWave, Wave, SemiWave, DarkWave
    case LightPebble, Pebble, SemiPebble, DarkPebble
    case LightTempura, Tempura, SemiTempura, DarkTempura
    case LightCoral, Coral, SemiCoral, DarkCoral
    case LightJade, Jade, SemiJade, DarkJade
    case LightBeige, Beige
    
    var color: UIColor {
        get {
            switch self {
            case .LightFuji:
                return UIColor(red: 174.0/255.0, green: 164.0/255.0, blue: 194.0/255.0, alpha: 1.0)
            case .Fuji:
                return UIColor(red: 118.0/255.0, green: 105.0/255.0, blue: 146.0/255.0, alpha: 1.0)
            case .SemiFuji:
                return UIColor(red: 77.0/255.0, green: 63.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            case .DarkFuji:
                return UIColor(red: 60.0/255.0, green: 49.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            case .LightBamboo:
                return UIColor(red: 171.0/255.0, green: 123.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            case .Bamboo:
                return UIColor(red: 141.0/255.0, green: 181.0/255.0, blue: 37.0/255.0, alpha: 1.0)
            case .SemiBamboo:
                return UIColor(red: 105.0/255.0, green: 143.0/255.0, blue: 14.0/255.0, alpha: 1.0)
            case .DarkBamboo:
                return UIColor(red: 83.0/255.0, green: 114.0/255.0, blue: 4.0/255.0, alpha: 1.0)
            case .LightWave:
                return UIColor(red: 118.0/255.0, green: 191.0/255.0, blue: 222.0/255.0, alpha: 1.0)
            case .Wave:
                return UIColor(red: 84.0/255.0, green: 160.0/255.0, blue: 191.0/255.0, alpha: 1.0)
            case .SemiWave:
                return UIColor(red: 26.0/255.0, green: 117.0/255.0, blue: 161.0/255.0, alpha: 1.0)
            case .DarkWave:
                return UIColor(red: 12.0/255.0, green: 84.0/255.0, blue: 121.0/255.0, alpha: 1.0)
            case .LightPebble:
                return UIColor(red: 178.0/255.0, green: 174.0/255.0, blue: 165.0/255.0, alpha: 1.0)
            case .Pebble:
                return UIColor(red: 143.0/255.0, green: 141.0/255.0, blue: 135.0/255.0, alpha: 1.0)
            case .SemiPebble:
                return UIColor(red: 95.0/255.0, green: 91.0/255.0, blue: 85.0/255.0, alpha: 1.0)
            case .DarkPebble:
                return UIColor(red: 67.0/255.0, green: 65.0/255.0, blue: 63.0/255.0, alpha: 1.0)
            case .LightTempura:
                return UIColor(red: 239.0/255.0, green: 168.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            case .Tempura:
                return UIColor(red: 202.0/255.0, green: 120.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            case .SemiTempura:
                return UIColor(red: 158.0/255.0, green: 85.0/255.0, blue: 18.0/255.0, alpha: 1.0)
            case .DarkTempura:
                return UIColor(red: 120.0/255.0, green: 58.0/255.0, blue: 2.0/255.0, alpha: 1.0)
            case .LightCoral:
                return UIColor(red: 240.0/255.0, green: 140.0/255.0, blue: 136.0/255.0, alpha: 1.0)
            case .Coral:
                return UIColor(red: 222.0/255.0, green: 97.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            case .SemiCoral:
                return UIColor(red: 179.0/255.0, green: 45.0/255.0, blue: 44.0/255.0, alpha: 1.0)
            case .DarkCoral:
                return UIColor(red: 147.0/255.0, green: 19.0/255.0, blue: 20.0/255.0, alpha: 1.0)
            case .LightJade:
                return UIColor(red: 135.0/255.0, green: 198.0/255.0, blue: 192.0/255.0, alpha: 1.0)
            case .Jade:
                return UIColor(red: 97.0/255.0, green: 168.0/255.0, blue: 161.0/255.0, alpha: 1.0)
            case .SemiJade:
                return UIColor(red: 49.0/255.0, green: 106.0/255.0, blue: 100.0/255.0, alpha: 1.0)
            case .DarkJade:
                return UIColor(red: 35.0/255.0, green: 87.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            case .LightBeige:
                return UIColor(red: 0.953, green: 0.949, blue: 0.933, alpha: 1.0)
            case .Beige:
                return UIColor(red: 0.898, green: 0.890, blue: 0.867, alpha: 1.0)
            }
        }
    }
}
