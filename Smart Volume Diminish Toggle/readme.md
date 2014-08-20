# Smart Volume Diminish Toggle
## A (sort of) quick script to detect your listening device and do what I refer to as a volume "diminish."
What do I mean by that? Well, you know when the phone rings and you don't necessarily want to *mute*? Or when you're listening to music and someone in the room starts speaking to you? I attach this script to a quick keystroke to *diminish* the volume to a low, but still audible level.

It's dead easy to mute/unmute with straight vanilla AppleScript, but what happens when you're wearing, say, headphones? Or listening to attached speakers? What's considered diminished (which for me is a step or two louder than *barely audible*) is different when I'm listening on my laptop's speakers, vs. my bluetooth speaker, vs my headphones.

This script will provide an example of the (somewhat clumsy) steps required to detect the output device and then set the new diminished volume accordingly. It will also store the previous volume, so that when you are done with whatever caused you to need to lower the volume in the first place you can invoke the same toggle keystroke to set it back to where it was before. Sweet.

Because the current output device is not so easily accessible, this script must launch System Prefs (background) and read the output device there. This takes about 3 seconds on first invocation of the script, but works in under a second thereafter, assuming you leave the System Prefs open in the background, which I do when I'm actively listening to music or radio and will likely be needing this functionality.

So there: The Inartfully-Named *Smart Volume Diminish Toggle.*

---
***Pro Tip:*** If you are using this script from within a macro editor (I use the amazingly excellent [Keyboard Maestro](http://www.keyboardmaestro.com/ "Keyboard Maestro 6.4.6: Work Faster with Macros for Mac OS X")), make sure you *link to the saved script file* instead of pasting the script code into the macro editor. Because of the `property` value stored to allow toggling *back* to your original volume, there must be a physical script file to write to.

---
#### My Current Key Command for this toggle is:

&#x2318;&#x2325;&#x2303;&#x21E7;&larr;

*or*

&#x2318;&#x2325;&#x2303;&#x21E7;&rarr;