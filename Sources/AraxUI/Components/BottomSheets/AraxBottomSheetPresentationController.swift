//
//  AraxBottomSheetPresentationController.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import UIKit

open class AraxBottomSheetPresentationController: UIPresentationController {
    
    public var dimmingView = UIView()
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmingView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(diTapDismiss))
        dimmingView.addGestureRecognizer(tapGesture)
    }
    
    @objc public func diTapDismiss() {
        self.presentedViewController.dismiss(animated: true)
    }
    
    open override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let targetSize = CGSize(width: containerView.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        let fittingHeight = presentedViewController.view.systemLayoutSizeFitting(
            targetSize
        ).height
        
        let topMargin = CGFloat(250)
        let maximumHeight = containerView.bounds.height - topMargin
        
        let height = min(fittingHeight, maximumHeight)
        
        return CGRect(
            x: 0,
            y: containerView.bounds.height - height,
            width: containerView.bounds.width,
            height: height
        )
    }
    
    open override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        containerView.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate { _ in
            self.dimmingView.alpha = 1
        }
    }
    
    open override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate { _ in
            self.dimmingView.alpha = 0
        }
    }
    
    open override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}

public final class AraxBottomSheetTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    public override init() { super.init() }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return AraxBottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return AraxBottomSheetAnimator(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return AraxBottomSheetAnimator(isPresenting: false)
    }
    
}

public final class AraxBottomSheetAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    public let isPresenting: Bool
    
    public init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        if isPresenting {
            container.addSubview(toView)
            
            let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
            toView.frame = finalFrame
            toView.frame.origin.y = container.bounds.height
            
            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.75,
                initialSpringVelocity: 0.7,
                options: [.curveEaseOut],
                animations: {
                    toView.frame = finalFrame
                },
                completion: { finished in
                    transitionContext.completeTransition(finished)
                }
            )
            
        } else {
            let finalY = container.bounds.height
            
            UIView.animate(
                withDuration: 0.35,
                animations: {
                    fromView.frame.origin.y = finalY
                },
                completion: { finished in
                    fromView.removeFromSuperview()
                    transitionContext.completeTransition(finished)
                }
            )
        }
    }
}
