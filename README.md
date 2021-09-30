# Input Plus+
# What is Input plus?
A Luau module for handling sequential input(s) easily and supporting holding input(s)

# Why Input plus?
Have you ever wanted to handle sequential inputs such as combos for double jumping,dashing and weapons or holding inputs? Well, Input plus could help you with that with making your code clean and performant. Input plus is very easy to use and supports any amount of keybinds.

# Features
<details>
  <summary>Sequence</summary>
  1) Sequences with delay specified (if delay is nil, no delay is included)<br>
  2) Any amount of keybinds can be put in the sequence.<br>
  3) Events to indicate starting of sequence,ending of sequence and pressing of keybinds<br>
  4) Feature to cancel the current input or reset the sequence.(Commonly used when gameProcessedEvent is true)<br>
</details>
<details>
  <summary>Hold</summary>
  1) Any amount of keybinds can be put in the holding list.<br>
  2) Events to indicate starting of holding,ending of holding and holding of specific keybinds<br>
  3) Feature to cancel the current input.(Commonly used when gameProcessedEvent is true)<br>
</details>

Get the module here : [Input plus+](https://www.roblox.com/library/7599649831/Input-Plus)<br>

# API
Main :
  Sequence - A module inside the Input module controlling the sequences.<br>
  Hold - A module insdie the Hold module controlling the holding inputs.<br>
  
  Sequence.new(Delay,keys) :<br>
    Arguments : <br>
      Delay is the maximum delay between each keybind triggering,if the delta time exceeds delay the sequence will reset.<br>
      Keys are the list of all the keys in **order** involved in the sequence.<br>
    Returns : <br>
      Start - BindableEvent indicating the starting of sequence<br>
      End - BindableEvent indicating the ending of sequence<br>
      Pressed - BindableEvent indicating the pressing of keybinds in the sequence, passes pressed : (Input,gameProcessedEvent,Index) :<br>
        Input : The current key pressed<br>
        gameProcessedEvent : The curret state of gameProcessedEvent <br>
        Index : The current Index the sequence is at, could use for combos to indicate the combo index.<br><br>
      Destroy - Function : To destroy the sequence and cleaning everything related to it<br>
      Cancel - Function : To cancel the current input pressed check examples for more details on use case.<br>
      Reset - Function : To reset the entire sequence<br>
      
  
  
Thanks to my friend [Legedy](https://www.roblox.com/users/1366383020/profile) for the "TypeDefinitions" module


