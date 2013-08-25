var search_data = {"index":{"searchIndex":["applicationcontroller","applicationhelper","attachment","attachmentscontroller","attachmentshelper","calendar","calendarscontroller","calendarshelper","location","locationscontroller","locationshelper","map","mapscontroller","mapshelper","peoplecontroller","peoplehelper","person","post","postscontroller","postshelper","staticpagescontroller","staticpageshelper","tag","tagscontroller","tagshelper","talk","talkscontroller","talkshelper","tweet","tweetscontroller","tweetshelper","about()","contact()","create()","create()","create()","create()","create()","create()","create()","create()","create()","credits()","destroy()","destroy()","destroy()","destroy()","destroy()","destroy()","destroy()","destroy()","destroy()","edit()","edit()","edit()","edit()","edit()","edit()","edit()","edit()","edit()","help()","index()","index()","index()","index()","index()","index()","index()","index()","index()","menu()","new()","new()","new()","new()","new()","new()","new()","new()","new()","privacy()","show()","show()","show()","show()","show()","show()","show()","show()","show()","splash()","update()","update()","update()","update()","update()","update()","update()","update()","update()","readme"],"longSearchIndex":["applicationcontroller","applicationhelper","attachment","attachmentscontroller","attachmentshelper","calendar","calendarscontroller","calendarshelper","location","locationscontroller","locationshelper","map","mapscontroller","mapshelper","peoplecontroller","peoplehelper","person","post","postscontroller","postshelper","staticpagescontroller","staticpageshelper","tag","tagscontroller","tagshelper","talk","talkscontroller","talkshelper","tweet","tweetscontroller","tweetshelper","staticpagescontroller#about()","staticpagescontroller#contact()","attachmentscontroller#create()","calendarscontroller#create()","locationscontroller#create()","mapscontroller#create()","peoplecontroller#create()","postscontroller#create()","tagscontroller#create()","talkscontroller#create()","tweetscontroller#create()","staticpagescontroller#credits()","attachmentscontroller#destroy()","calendarscontroller#destroy()","locationscontroller#destroy()","mapscontroller#destroy()","peoplecontroller#destroy()","postscontroller#destroy()","tagscontroller#destroy()","talkscontroller#destroy()","tweetscontroller#destroy()","attachmentscontroller#edit()","calendarscontroller#edit()","locationscontroller#edit()","mapscontroller#edit()","peoplecontroller#edit()","postscontroller#edit()","tagscontroller#edit()","talkscontroller#edit()","tweetscontroller#edit()","staticpagescontroller#help()","attachmentscontroller#index()","calendarscontroller#index()","locationscontroller#index()","mapscontroller#index()","peoplecontroller#index()","postscontroller#index()","tagscontroller#index()","talkscontroller#index()","tweetscontroller#index()","staticpagescontroller#menu()","attachmentscontroller#new()","calendarscontroller#new()","locationscontroller#new()","mapscontroller#new()","peoplecontroller#new()","postscontroller#new()","tagscontroller#new()","talkscontroller#new()","tweetscontroller#new()","staticpagescontroller#privacy()","attachmentscontroller#show()","calendarscontroller#show()","locationscontroller#show()","mapscontroller#show()","peoplecontroller#show()","postscontroller#show()","tagscontroller#show()","talkscontroller#show()","tweetscontroller#show()","staticpagescontroller#splash()","attachmentscontroller#update()","calendarscontroller#update()","locationscontroller#update()","mapscontroller#update()","peoplecontroller#update()","postscontroller#update()","tagscontroller#update()","talkscontroller#update()","tweetscontroller#update()",""],"info":[["ApplicationController","","ApplicationController.html","",""],["ApplicationHelper","","ApplicationHelper.html","",""],["Attachment","","Attachment.html","","<p>get trigger support in for the attachments\n"],["AttachmentsController","","AttachmentsController.html","",""],["AttachmentsHelper","","AttachmentsHelper.html","",""],["Calendar","","Calendar.html","","<p>Calendar – virtual table at this point, maintained to give ruby-oid\nstructure to web pages\n<p>Associated …\n"],["CalendarsController","","CalendarsController.html","",""],["CalendarsHelper","","CalendarsHelper.html","",""],["Location","","Location.html","","<p>Locations – map or virtual locations\n<p>Associated with talks, people, posts, tweets, possibly some other …\n"],["LocationsController","","LocationsController.html","",""],["LocationsHelper","","LocationsHelper.html","",""],["Map","","Map.html","","<p>Map – virtual table at this point, maintained to give ruby-oid structure to\nweb pages\n<p>Associated with …\n"],["MapsController","","MapsController.html","",""],["MapsHelper","","MapsHelper.html","",""],["PeopleController","","PeopleController.html","","<p>will be adding actions:  login, logout, settings (edit)\n\n<pre>will be adding validation on name, email\nwill ...</pre>\n"],["PeopleHelper","","PeopleHelper.html","",""],["Person","","Person.html","","<p>People\n<p>Fields\n<p>name – string, unique, mandatory\n"],["Post","","Post.html","","<p>Posts – Associated with Talks\n<p>Made by a user with respect to a talk\n<p>Starting point for Tweets\n"],["PostsController","","PostsController.html","",""],["PostsHelper","","PostsHelper.html","",""],["StaticPagesController","","StaticPagesController.html","",""],["StaticPagesHelper","","StaticPagesHelper.html","",""],["Tag","","Tag.html","","<p>Tags – Polymorphic, point up to basically everything:\n<p>Talks\n<p>Users\n"],["TagsController","","TagsController.html","",""],["TagsHelper","","TagsHelper.html","",""],["Talk","","Talk.html","","<p>Talks – Key table, this is what we invite people to!\n<p>Currently, curiously short\n<p>Fields\n"],["TalksController","","TalksController.html","",""],["TalksHelper","","TalksHelper.html","",""],["Tweet","","Tweet.html","","<p>Tweet – like a post, but more general\n<p>There are lots of tweets we might track that don&#39;t point to …\n"],["TweetsController","","TweetsController.html","",""],["TweetsHelper","","TweetsHelper.html","",""],["about","StaticPagesController","StaticPagesController.html#method-i-about","()",""],["contact","StaticPagesController","StaticPagesController.html#method-i-contact","()",""],["create","AttachmentsController","AttachmentsController.html#method-i-create","()","<p>POST /attachments POST /attachments.json\n"],["create","CalendarsController","CalendarsController.html#method-i-create","()","<p>POST /calendars POST /calendars.json\n"],["create","LocationsController","LocationsController.html#method-i-create","()","<p>POST /locations POST /locations.json\n"],["create","MapsController","MapsController.html#method-i-create","()","<p>POST /maps POST /maps.json\n"],["create","PeopleController","PeopleController.html#method-i-create","()","<p>POST /people POST /people.json\n"],["create","PostsController","PostsController.html#method-i-create","()","<p>POST /posts POST /posts.json\n"],["create","TagsController","TagsController.html#method-i-create","()","<p>POST /tags POST /tags.json\n"],["create","TalksController","TalksController.html#method-i-create","()","<p>POST /talks POST /talks.json\n"],["create","TweetsController","TweetsController.html#method-i-create","()","<p>POST /tweets POST /tweets.json\n"],["credits","StaticPagesController","StaticPagesController.html#method-i-credits","()",""],["destroy","AttachmentsController","AttachmentsController.html#method-i-destroy","()","<p>DELETE /attachments/1 DELETE /attachments/1.json be careful to destroy the\nattached file at the same …\n"],["destroy","CalendarsController","CalendarsController.html#method-i-destroy","()","<p>DELETE /calendars/1 DELETE /calendars/1.json\n"],["destroy","LocationsController","LocationsController.html#method-i-destroy","()","<p>DELETE /locations/1 DELETE /locations/1.json\n"],["destroy","MapsController","MapsController.html#method-i-destroy","()","<p>DELETE /maps/1 DELETE /maps/1.json\n"],["destroy","PeopleController","PeopleController.html#method-i-destroy","()","<p>DELETE /people/1 DELETE /people/1.json\n"],["destroy","PostsController","PostsController.html#method-i-destroy","()","<p>DELETE /posts/1 DELETE /posts/1.json\n"],["destroy","TagsController","TagsController.html#method-i-destroy","()","<p>DELETE /tags/1 DELETE /tags/1.json\n"],["destroy","TalksController","TalksController.html#method-i-destroy","()","<p>DELETE /talks/1 DELETE /talks/1.json\n"],["destroy","TweetsController","TweetsController.html#method-i-destroy","()","<p>DELETE /tweets/1 DELETE /tweets/1.json\n"],["edit","AttachmentsController","AttachmentsController.html#method-i-edit","()","<p>GET /attachments/1/edit\n"],["edit","CalendarsController","CalendarsController.html#method-i-edit","()","<p>GET /calendars/1/edit\n"],["edit","LocationsController","LocationsController.html#method-i-edit","()","<p>GET /locations/1/edit\n"],["edit","MapsController","MapsController.html#method-i-edit","()","<p>GET /maps/1/edit\n"],["edit","PeopleController","PeopleController.html#method-i-edit","()","<p>GET /people/1/edit\n"],["edit","PostsController","PostsController.html#method-i-edit","()","<p>GET /posts/1/edit\n"],["edit","TagsController","TagsController.html#method-i-edit","()","<p>GET /tags/1/edit\n"],["edit","TalksController","TalksController.html#method-i-edit","()","<p>GET /talks/1/edit\n"],["edit","TweetsController","TweetsController.html#method-i-edit","()","<p>GET /tweets/1/edit\n"],["help","StaticPagesController","StaticPagesController.html#method-i-help","()",""],["index","AttachmentsController","AttachmentsController.html#method-i-index","()","<p>GET /attachments GET /attachments.json\n"],["index","CalendarsController","CalendarsController.html#method-i-index","()","<p>GET /calendars GET /calendars.json\n"],["index","LocationsController","LocationsController.html#method-i-index","()","<p>GET /locations GET /locations.json\n"],["index","MapsController","MapsController.html#method-i-index","()","<p>GET /maps GET /maps.json\n"],["index","PeopleController","PeopleController.html#method-i-index","()","<p>GET /people GET /people.json\n"],["index","PostsController","PostsController.html#method-i-index","()","<p>GET /posts GET /posts.json\n"],["index","TagsController","TagsController.html#method-i-index","()","<p>GET /tags GET /tags.json\n"],["index","TalksController","TalksController.html#method-i-index","()","<p>GET /talks GET /talks.json\n"],["index","TweetsController","TweetsController.html#method-i-index","()","<p>GET /tweets GET /tweets.json\n"],["menu","StaticPagesController","StaticPagesController.html#method-i-menu","()",""],["new","AttachmentsController","AttachmentsController.html#method-i-new","()","<p>GET /attachments/new\n"],["new","CalendarsController","CalendarsController.html#method-i-new","()","<p>GET /calendars/new\n"],["new","LocationsController","LocationsController.html#method-i-new","()","<p>GET /locations/new\n"],["new","MapsController","MapsController.html#method-i-new","()","<p>GET /maps/new\n"],["new","PeopleController","PeopleController.html#method-i-new","()","<p>GET /people/new\n"],["new","PostsController","PostsController.html#method-i-new","()","<p>GET /posts/new\n"],["new","TagsController","TagsController.html#method-i-new","()","<p>GET /tags/new\n"],["new","TalksController","TalksController.html#method-i-new","()","<p>GET /talks/new\n"],["new","TweetsController","TweetsController.html#method-i-new","()","<p>GET /tweets/new\n"],["privacy","StaticPagesController","StaticPagesController.html#method-i-privacy","()",""],["show","AttachmentsController","AttachmentsController.html#method-i-show","()","<p>GET /attachments/1 GET /attachments/1.json\n"],["show","CalendarsController","CalendarsController.html#method-i-show","()","<p>GET /calendars/1 GET /calendars/1.json\n"],["show","LocationsController","LocationsController.html#method-i-show","()","<p>GET /locations/1 GET /locations/1.json\n"],["show","MapsController","MapsController.html#method-i-show","()","<p>GET /maps/1 GET /maps/1.json\n"],["show","PeopleController","PeopleController.html#method-i-show","()","<p>GET /people/1 GET /people/1.json\n"],["show","PostsController","PostsController.html#method-i-show","()","<p>GET /posts/1 GET /posts/1.json\n"],["show","TagsController","TagsController.html#method-i-show","()","<p>GET /tags/1 GET /tags/1.json\n"],["show","TalksController","TalksController.html#method-i-show","()","<p>GET /talks/1 GET /talks/1.json\n"],["show","TweetsController","TweetsController.html#method-i-show","()","<p>GET /tweets/1 GET /tweets/1.json\n"],["splash","StaticPagesController","StaticPagesController.html#method-i-splash","()",""],["update","AttachmentsController","AttachmentsController.html#method-i-update","()","<p>PATCH/PUT /attachments/1 PATCH/PUT /attachments/1.json\n"],["update","CalendarsController","CalendarsController.html#method-i-update","()","<p>PATCH/PUT /calendars/1 PATCH/PUT /calendars/1.json\n"],["update","LocationsController","LocationsController.html#method-i-update","()","<p>PATCH/PUT /locations/1 PATCH/PUT /locations/1.json\n"],["update","MapsController","MapsController.html#method-i-update","()","<p>PATCH/PUT /maps/1 PATCH/PUT /maps/1.json\n"],["update","PeopleController","PeopleController.html#method-i-update","()","<p>PATCH/PUT /people/1 PATCH/PUT /people/1.json\n"],["update","PostsController","PostsController.html#method-i-update","()","<p>PATCH/PUT /posts/1 PATCH/PUT /posts/1.json\n"],["update","TagsController","TagsController.html#method-i-update","()","<p>PATCH/PUT /tags/1 PATCH/PUT /tags/1.json\n"],["update","TalksController","TalksController.html#method-i-update","()","<p>PATCH/PUT /talks/1 PATCH/PUT /talks/1.json\n"],["update","TweetsController","TweetsController.html#method-i-update","()","<p>PATCH/PUT /tweets/1 PATCH/PUT /tweets/1.json\n"],["README","","README_rdoc.html","","<p>TalkInvite\n<p>Objective\n<p>Demo skill set, get an app up.\n"]]}}