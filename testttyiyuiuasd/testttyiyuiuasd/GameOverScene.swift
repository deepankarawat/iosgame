//
//  GameOverScene.swift
//  testttyiyuiuasd
//
//  Created by test on 2021-05-22.
//  Copyright © 2021 ca.vladbordiug. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverScene:SKScene{
    var message:String = ""
    override func didMove(to view: SKView) {
        let label = self.childNode(withName: "label") as! SKLabelNode
        label.text = message
        
    }
}

