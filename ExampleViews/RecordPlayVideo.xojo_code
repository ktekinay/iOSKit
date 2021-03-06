#tag IOSView
Begin iosView RecordPlayVideo
   BackButtonTitle =   "Back"
   Compatibility   =   ""
   Left            =   0
   NavigationBarVisible=   True
   TabTitle        =   ""
   Title           =   "Record and Play Video"
   Top             =   0
   Begin iOSButton Button1
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button1, 9, <Parent>, 9, False, +1.00, 1, 1, 0, 
      AutoLayout      =   Button1, 3, <Parent>, 3, False, +1.00, 1, 1, 138, 
      AutoLayout      =   Button1, 8, , 0, False, +1.00, 1, 1, 30, 
      AutoLayout      =   Button1, 7, , 0, False, +1.00, 1, 1, 100, 
      Caption         =   "Record"
      Enabled         =   True
      Height          =   30.0
      Left            =   110
      LockedInPosition=   False
      Scope           =   0
      TextColor       =   &c007AFF00
      TextFont        =   ""
      TextSize        =   0
      Top             =   138
      Visible         =   True
      Width           =   100.0
   End
   Begin iOSButton Button2
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button2, 1, Button1, 1, False, +1.00, 1, 1, 0, 
      AutoLayout      =   Button2, 3, <Parent>, 3, False, +1.00, 1, 1, 330, 
      AutoLayout      =   Button2, 8, , 0, False, +1.00, 1, 1, 30, 
      AutoLayout      =   Button2, 2, Button1, 2, False, +1.00, 1, 1, 0, 
      Caption         =   "Play"
      Enabled         =   True
      Height          =   30.0
      Left            =   110
      LockedInPosition=   False
      Scope           =   0
      TextColor       =   &c007AFF00
      TextFont        =   ""
      TextSize        =   0
      Top             =   330
      Visible         =   True
      Width           =   100.0
   End
End
#tag EndIOSView

#tag WindowCode
	#tag Method, Flags = &h0
		Sub HandlePictureTaken(sender as UIKit.UIImagePickerController)
		  mediaURL = sender.mediaURL
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Play()
		  if mediaURL <> nil then
		    player = new Extensions.MPMoviePlayerController(mediaURL)
		    player.prepareToPlay
		    
		    dim viewBounds as new NSRect
		    viewBounds.rsize = new NSSize(self.Size.Width,self.Size.Height)
		    #if Target32Bit
		      declare sub setBounds lib UIKitLib selector "setBounds:" (obj_id as ptr, bounds as NSRect32)
		      setBounds(player.view,viewBounds.Value32)
		    #Elseif Target64Bit
		      declare sub setBounds lib UIKitLib selector "setBounds:" (obj_id as ptr, bounds as NSRect64)
		      setBounds(player.view,viewBounds.Value64)
		    #Endif
		    
		    dim viewPtr as Ptr = self.View
		    declare sub addSubview lib UIKitLib selector "addSubview:" (obj_id as ptr, view as ptr)
		    addSubview(viewPtr,player.view)
		    
		    player.play
		    
		    player.fullscreen = True
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Record()
		  if recorder <> nil then
		    RemoveHandler recorder.PictureTaken, AddressOf HandlePictureTaken
		  end if
		  
		  recorder = new UIKit.UIImagePickerController
		  AddHandler recorder.PictureTaken, AddressOf HandlePictureTaken
		  
		  recorder.sourceType = UIKit.UIImagePickerController.Source.Camera
		  recorder.mediaTypes = Foundation.NSArray.CreateWithObject(new NSString(UIKit.UIImagePickerController.kUTTypeMovie))
		  
		  recorder.PresentInView(self)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		mediaURL As Foundation.NSURL
	#tag EndProperty

	#tag Property, Flags = &h0
		player As Extensions.MPMoviePlayerController
	#tag EndProperty

	#tag Property, Flags = &h0
		recorder As UIKit.UIImagePickerController
	#tag EndProperty


#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Action()
		  Record
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Action()
		  Play
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="BackButtonTitle"
		Group="Behavior"
		Type="Text"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="NavigationBarVisible"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabTitle"
		Group="Behavior"
		Type="Text"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Group="Behavior"
		Type="Text"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
