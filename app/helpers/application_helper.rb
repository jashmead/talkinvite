# appears code here is accessible from inside a form, but not from inside a controller
module ApplicationHelper
  ## see http://stackoverflow.com/questions/3326579/rails3-get-current-layout-name-inside-view
  def current_layout
    # call interior function controller._layout
    layout = controller.send(:_layout)
    if layout.instance_of? String
      layout
    else
      ## layout.identifier = /Volumes/Isis/talkinvite/talkinvite/app/views/layouts/application.html.erb
      File.basename(layout.identifier).split('.').first ## gives "application"
    end
  end
end
