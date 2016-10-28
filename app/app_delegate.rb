class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    #Used for displaying controllers
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'FontShift'
    rootViewController.view.backgroundColor = UIColor.blackColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    #Create the UI Window, which allows us to create all UIViews
    #UIScreen will utilize the entire display, not just what we specify
    #Note: This also puts your app beneath the status bar.
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    #UIWindow tells system it will be the window receiving touch events,
    #draw it to the screen
    @window.makeKeyAndVisible

#####LABELS START

    #Toggle Text Label
    @switch_font_label = UILabel.alloc.initWithFrame(CGRectZero)
    @switch_font_label.sizeToFit
    @switch_font_label.textAlignment = UITextAlignmentCenter
    @switch_font_label.backgroundColor = UIColor.clearColor
    @switch_font_label.textColor = UIColor.whiteColor
    @switch_font_label.font = UIFont.fontWithName("Avenir-Black",size:24)
    @switch_font_label.text = "Weight"
    @switch_font_label.frame = CGRectMake(160, 180, 100, 50)
    @window.addSubview(@switch_font_label)

    #Slider Text Label
    @slider_label = UILabel.alloc.initWithFrame(CGRectZero)
    @slider_label.sizeToFit
    @slider_label.textAlignment = UITextAlignmentCenter
    @slider_label.backgroundColor = UIColor.clearColor
    @slider_label.textColor = UIColor.whiteColor
    @slider_label.font = UIFont.fontWithName("Avenir-Black",size:24)
    @slider_label.text = "Size"
    @slider_label.frame = CGRectMake(150, 250, 60, 50)
    #Without the addSubview it will not display on the screen
    @window.addSubview(@slider_label)

    #Text Field Text Label
    @color_label = UILabel.alloc.initWithFrame(CGRectZero)
    @color_label.sizeToFit
    @color_label.textAlignment = UITextAlignmentCenter
    @color_label.backgroundColor = UIColor.clearColor
    @color_label.textColor = UIColor.whiteColor
    @color_label.font = UIFont.fontWithName("Avenir-Black",size:24)
    @color_label.text = "Color"
    @color_label.frame = CGRectMake(140, 340, 80, 50)
    @window.addSubview(@color_label)

    #Picker Text Label
    #Used another way to create the frame with the picker label, shouldn't matter, though
    @picker_label = UILabel.new
    @picker_label.textAlignment = UITextAlignmentCenter
    @picker_label.backgroundColor = UIColor.clearColor
    @picker_label.textColor = UIColor.whiteColor
    @picker_label.font = UIFont.fontWithName("Avenir-Black",size:24)
    @picker_label.text = "Decoration"
    @picker_label.frame = [[130,440],[120,50]]
    @picker_label.numberOfLines = 2
    @picker_label.adjustsFontSizeToFitWidth = true
    @window.addSubview(@picker_label)

######LABELS END




    #The actual toggle / change_font_decor
    @switch_font = UISwitch.alloc.initWithFrame([[100,190],[5,5]])
    @switch_font.tintColor = UIColor.yellowColor #switch border if toggled OFF
    @switch_font.onTintColor = UIColor.yellowColor #switch border if toggled ON
    @switch_font.thumbTintColor = UIColor.redColor #switch itself
    @switch_font.addTarget(self,action: "change_font_decor",forControlEvents:UIControlEventValueChanged)
    @window.addSubview(@switch_font)






    #The actual slider / change_font_size
    @size_slider = UISlider.alloc.initWithFrame([[10, 295], [355, 40]])
    @size_slider.minimumValue = 0.0
    @size_slider.maximumValue = 1.0
    @size_slider.continuous = false
    @size_slider.addTarget(self, action:"change_font_size", forControlEvents:UIControlEventValueChanged)
    @window.addSubview(@size_slider)





    #The actual text field / change_font_color
    @color_field = UITextField.alloc.initWithFrame([[150, 390], [120, 60]])
    @color_field.textAlignment = UITextAlignmentCenter
    @color_field.backgroundColor = UIColor.whiteColor
    @color_field.text = "yellow"
    @color_field.placeholder = "Color"
    @color_field.adjustsFontSizeToFitWidth = true
    @color_field.enablesReturnKeyAutomatically = true
    @color_field.setBorderStyle UITextBorderStyleRoundedRect
    @color_field.returnKeyType = UIReturnKeyDone
    @color_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    # #sizeToFit needs to be here or the text field will not expand
    @color_field.sizeToFit
    @window.addSubview(@color_field)

    #Objects use delegates to send callback events.
    #UITextFieldDelegate lists all of the methods delegate object can implement
    @color_field.delegate = self






    #The actual picker
    @decor_picker = UIPickerView.new
    @decor_picker.backgroundColor = UIColor.whiteColor
    @decor_picker.frame = [[80, 490], [200,70]]
    @decor_picker.delegate = self
    @decor_picker.dataSource = self
    @window.addSubview(@decor_picker)

    #Set @font_color to a default color
    @font_color = UIColor.yellowColor



#######DYNAMIC LABEL


    #Dynamic Text Label
    @font_label = UILabel.alloc.initWithFrame(CGRectZero)
    @font_label.sizeToFit
    @font_label.textAlignment = UITextAlignmentCenter
    @font_label.backgroundColor = UIColor.clearColor
    @font_label.textColor = @font_color
    @font_label.frame = CGRectMake(60, -40, 280, 320)
    @font_label.adjustsFontSizeToFitWidth = true

    #Call change_font_size so the @font_size can change dynamically
    change_font_size
    @font_label.text = "Baskerville"
    @font_label.font = UIFont.fontWithName("Baskerville",size:@font_size)
    @window.addSubview(@font_label)
    change_font_decor

    #This is essentially saying we want the app to launch.
    #Alternatively we could use launchOptions to make the decision based on reasons.
    true

  end

########TOGGLE

  #toggle switch method
  def change_font_decor
    #If toggled to on, font is bold, otherwise not bold.
    # Best case here is to use NSAttributedString
    if @switch_font.on? == true
      @font_label.font = UIFont.fontWithName("#{@font_label.text}-Bold",size:@font_size)
    else
      @font_label.font = UIFont.fontWithName("#{@font_label.text}",size:@font_size)
    end
  end





########TEXT FIELD


  #text field method
  def change_font_color
    #Code essentially used from Clay Allsop's RubyMotion: iOS Development with Ruby
    #with a few tweeks
    #
    #Get the color_field text
    color_prefix = @color_field.text
    #Downcase the color_field text and append "Color"
    color_method = "#{color_prefix.downcase}Color"
    #If the color exists, create as UIColor.colorColor
    if UIColor.respond_to?(color_method)
      @font_color = UIColor.send(color_method)
      @font_label.textColor = @font_color
      #For fun I added that the text color also becomes the toggle background color when ON
      @switch_font.onTintColor = @font_color
      @switch_font.tintColor = @font_color
    else
      #If the color is not known, display an alert to inform user
      UIAlertView.alloc.initWithTitle("Invalid Color",
        message: "#{color_prefix.capitalize} is not a usable color at this time",
        delegate: nil,
        cancelButtonTitle: "OK",
        otherButtonTitles: nil).show
    end
  end

  #From Clay Allsop's book:
  #resignFirstResponder hides keyboard, as first responder in responder chain
  #is usually the virtual keyboard.  Responder chain determines events such as taps
  #being propagated.
  #
  #Whatever is returned from this method decides UITextField carrying out default
  #behavior from Return Key.  Since we're hiding keyboard, normal action should be avoided.
  #This is why we call textFieldShouldReturn, to intercept when Return/Done key is pressed.
  def textFieldShouldReturn(textField)
    change_font_color
    textField.resignFirstResponder
    false
  end




######PICKER


  #Picker Field.
  #First method sets up 3 rows in the picker
  def pickerView(pickerView, numberOfRowsInComponent:component)
    3
  end

  #Second picker method uses a case to label each row in the picker
  def pickerView(pickerView, titleForRow:row, forComponent:component)
    case row
    # iosfonts.com
    when 0
      pickerView = "Baskerville"
    when 1
      pickerView = "HelveticaNeue"
    when 2
      pickerView = "Copperplate"
    end
  end

  #Third method for the picker lists the number of components.
  #Component = wheel.
  #Example, if making a date picker one could use 3 components: month, day, year
  def numberOfComponentsInPickerView(pickerView)
    1
  end

  #Note: Rows and components start at 0, not 1, when selecting them.
  #
  #This method for picker uses a case to let the user select which font from
  #the picker wheel they want, then set it as the dynamic font label.  If the
  #toggle is turned on, the font will remain bold.
  def pickerView(pickerView, didSelectRow:row, inComponent:component)
    if @switch_font.on? == true
      case row
      when 0
        @font_label.font = UIFont.fontWithName("Baskerville-Bold",size:@font_size)
        @font_label.text = "Baskerville"
      when 1
        @font_label.font = UIFont.fontWithName("HelveticaNeue-Bold",size:@font_size)
        @font_label.text = "HelveticaNeue"
      when 2
        @font_label.font = UIFont.fontWithName("Copperplate-Bold",size:@font_size)
        @font_label.text = "Copperplate"
      end
    else
      case row
      when 0
        @font_label.font = UIFont.fontWithName("Baskerville",size:@font_size)
        @font_label.text = "Baskerville"
      when 1
        @font_label.font = UIFont.fontWithName("HelveticaNeue",size:@font_size)
        @font_label.text = "HelveticaNeue"
      when 2
        @font_label.font = UIFont.fontWithName("Copperplate",size:@font_size)
        @font_label.text = "Copperplate"
      end
    end
  end




#############SLIDER


  #slider method to change font size
  #
  #Slider uses between 0.0 and 1.0 values. Equation finds the value user ends on,
  #which is not always rounded exactly, and changes it to a font size value.
  #Credit to Brian Hogan for helping me with the math on this one.
  def change_font_size
    @font_size = 20*(@size_slider.value*2)+20
    #Use change_font_decor to maintain if font is bold or not
    change_font_decor
  end
end

# NOTES


  # HISTORY
  # In 2008 Apple announced MacRuby, and by 2010 was an alternative to Objective-C. By 2011 the Mac App Store released, 
			# and MacRuby apps were welcome.  In late 2011 MacRuby's creator and lead developer Laurent Sansonetti left Apple 
			# to pursue bringing Ruby to iOS development, thus starting HipByte.  Half way through 2012 RubyMotion 1.0 was released.
			# Laurent currently manages HipByte from his home in Belgium.

  #To create use in Terminal "motion create AppName"
  #motion is similar to the rails command, managing projects and RM tools
  #



  # RAKEFILE
  #In RakeFile one could add app.delegate_class = "ClassName"
  # By default, there is no app.icons. But it is necessary to be plural to even 
  # add one icon.  Just remember to include the image in resources directory.
  # According to stackoverflow a mac icon must be .icns extension, but I've not yet tried that out
  
  #This will change the name of the app and provide an icon on the phone "desktop"
  #Also note that app.icon, singular, won't work.  But an array of one will.
  #Be sure to place the image into the "Resources" directory
  #If the icon/name do not change, may need to run "rake clean", but do note that
  #this command will keep the old app on the desktop of the phone, and only deletes
  #the ./build file



  # NAMED ARGS
  # 
  # Named Args: Variable proceeds part of the function name which refers to it using colons.
  #Ruby currently as these, but at one point did not. RM uses so Ruby can communicate to Apple APIs

  #Typically run "rake" from the directory to run the application
  #
  #Since I'm using vim, instead of exiting text editing, rake, stopping app,
  #and going back into vim, then finding the line I was on I can simply use
  #:!rake which will run rake, and when the app stops take me to the exact line
  #I was on when I ran it



    #Interactive debug example.  When app is running, type the following into
    #Terminal to get
    #access to the @font_label
    #f = UIApplication.sharedApplication.delegate.instance_variable_get("@font_label")
    #
    #Note it could be cut up as other variables, i.e. app = UIApplication.sharedApplication
    #del = app.delegate, f = delegate.instance_variable_get("@font_label")
    #
    #Now that we have @font_label as the variable f, we can dynamically change it
    #f.text = "Hello"
    #And voila!
    #
    #This can also be done to create alerts, or to change other things on the fly
    #without having to stop and start the app with every change.
