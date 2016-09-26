## Autolayout bug for keyboard extensions trying to achieve an automatic (default) height

When creating a keyboard extension and not specifying a concrete height for its components but instead anchoring them to the view/inputView so that in theory the system will determine their height based on environment and orientation, in some situations that height instead turns into 0 and the keyboard is crushed (with the exception of anything that has a concrete height such as a self sized label or button).

**This only seems to occur on iOS 10.** On iOS 9, the child views resized correctly to fit the default automatic keyboard height.

There are several scenarios this can manifest and this project demonstrates a basic one. It starts with the basic keyboard extension template with the default "next keyboard" button and the 2 size constraints it comes with:
```
self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
```

Next, we create a single other view that we want to fill the space of the superview without defining a concrete size for itself:
```
let anotherView = UIView()
anotherView.backgroundColor = UIColor.red
anotherView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(anotherView)
anotherView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
anotherView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
anotherView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
```
Now, let's say we just want to anchor this new view to the bottom of our keyboard superview. We would just do something like: 
```
anotherView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
```

The result looks like this:

iOS 9
<img src="iOS%209%20-%20example%201(works).png" width="150" align="top">

iOS 10
<img src="iOS%2010%20-%20example%201(works).png" width="150"align="top">

This layout is exactly what we expect. Now instead, let's anchor the new view to the top of our next keyboard button. We get rid of the constraint we just added and replace it with
```
anotherView.bottomAnchor.constraint(equalTo: self.nextKeyboardButton.topAnchor).isActive = true
```

Logically, the resulting height should be the same (determined by the system)

The result is now this:

iOS 9
<img src="iOS%209%20-%20example%202(works).png" width="150" align="top">

iOS 10
<img src="iOS%2010%20-%20example%202(broken).png" width="150"align="top">

On iOS 9 it behaves as expected but on iOS 10, the flexible height view is resized down to 0 and all that is left is the fixed height button.
