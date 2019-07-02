//
//  GLTFSceneSource.swift
//  GLTFSceneKit
//
//  Created by magicien on 2017/08/17.
//  Copyright © 2017 DarkHorse. All rights reserved.
//

import SceneKit

@objcMembers
@available(iOS 10.0, *)
public class GLTFSceneSource : SCNSceneSource {
    private let loader: GLTFUnarchiver
    
    public init?(url: URL, options: [SCNSceneSource.LoadingOption : Any]?, extensions: [String:Codable.Type]?) {
        guard let loader = try? GLTFUnarchiver(url: url, extensions: extensions) else {
            return nil
        }
        self.loader = loader
        super.init(url: url, options: options)
    }
    
    public override func scene(options: [SCNSceneSource.LoadingOption : Any]? = nil) throws -> SCNScene {
        let scene = try self.loader.loadScene()
        #if SEEMS_TO_HAVE_SKINNER_VECTOR_TYPE_BUG
            let sceneData = NSKeyedArchiver.archivedData(withRootObject: scene)
            let source = SCNSceneSource(data: sceneData, options: nil)!
            let newScene = source.scene(options: nil)!
            return newScene
        #else
            return scene
        #endif
    }
    
    /*
    public func cameraNodes() -> [SCNNode] {
        var cameraNodes = [SCNNode]()
    
        let scene = try self.loader.loadScene()
        scene.rootNode.childNodes
     
        return cameraNodes
    }
     */
}
