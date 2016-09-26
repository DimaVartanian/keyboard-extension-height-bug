## autolayout bug for keyboard extensions trying to achieve an automatic (default) height

When creating a keyboard extension and not specifying a concrete height for its components but instead anchoring them to the view/inputView so that in theory the system will determine their height based on environment and orientation, in some situations that height instead turns into 0 and the keyboard is crushed (with the exception of anything that has a concrete height such as a self sized label or button).

**This only seems to occur on iOS 10.** On iOS 9, the child views resized correctly to fit the default automatic keyboard height.

There are several scenarios this can manifest and this project demonstrates a basic one.
