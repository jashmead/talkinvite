class Notifier < ActionMailer::Base
  # TBD:  switch from depending on environment

  # default from: "talkinvite@talkinvite.com"
  # default is a hash available to all emails
  default from: "taqm"

=begin
options to mail:

  attachments, e.g.:
    attachments[file_name, e.g. "image.png"] = File.read(public_path_name, i.e. "/images/image.png")
    -- to do inline, use
      attachments.inline["image.png"] = File.read("/images/image.png")
    -- in body you can use:
      <%= image_tag attachments['image.png'].url, alt: 'title of image' %>

  -- if using 'url_for', need to specify the controller & action, e.g.
    <%= url_for(controller: "people", action: "update") %>
    
  headers
  mail -- if no block, then use view with same name as method, i.e. the view 'notice'
  subject
  to -- as string or array
  from -- as string, mandatory
  cc, bcc -- string or array
  reply_to
  date -- defaults to Time.now
  
  notice function will automatically use layout notifiers/notice
    -- can use: layout 'notice' if desired

  to send the email:
    message = Notifier.notice(person, 'post', post)
    message.deliver

  to receive, test, configure mail service, look at p477-481 of The Rails 3 Way
    -- attachments are included

  to send, can use a 'runner', a script
    or call from controller using the above code
  
=end

  def notice(person, notice_type = 'post', post = nil)

    logger.debug("PeopleController.create: person: #{@person.inspect}, notice_type: #{notice_type}, post: #{post.inspect}")

    # set up variables for view, all attributes here are passed along automatically
    @person = person
    @notice_type = notice_type
    @post = post
    @url = signin_url(host: 'localhost', controller: 'people', action: 'signin')

    mail(
      to: 'taqm', # I should see these in taqm's mail queue
      subject: 'Notice'
    )
  end

end
