class Category

  @@categories = '{"tixcast":1,"uberseat":95,"checkout-api":54,"web checkout":43,"postmortem":12,"bunyan":20,"email":26,"ui":8,"ledgerman":4,"rescraper":8,"monitoring":4,"ticket":1,"outages":1,"chairnerd":5,"columbus":4,"team":25,"bunyan-admin":9,"tickets":1,"seo":17,"gogeek":9,"omnibox":46,"staging":7,"ops":11,"deal score":2,"mobile":34,"broker":1,"partners":1,"analytics":4,"layout":4,"autocomplete":12,"recon":24,"location":1,"friends":1,"user":4,"search":8,"api":46,"composer":1,"account":20,"wiki":10,"cms":5,"event":27,"price pages":4,"frops":21,"onboarding":9,"code style":1,"rfc":1,"tracker service":1,"ticketparse":4,"app":18,"febreze":3,"frontend":11,"web checkout v2":4,"mercury":4,"transfer":1,"malone":4,"buster":26,"ci":1,"images":6,"post-purchase":2,"turtle":1,"listingfeed":15,"apple pay":1,"alerts":15,"meta page":1,"database":2,"sg cookie":1,"rabbitmq":3,"a/b":2,"enterprise":1,"checkout":2,"mobile checkout":4,"transactions":5,"markets":10,"limelight":9,"es":1,"makefile":1,"stubhub":1,"design":4,"sgscripts":1,"the":7,"march madness":3,"plot":2,"recurring":8,"catalog":1,"vm":35,"event info":1,"pr":4,"notify":2,"promocode":2,"ie9":1,"security":15,"admin":8,"customer service":4,"mobile web":5,"ingestion":8,"vfs":2,"db":2,"apollo":4,"menu":1,"seating charts":5,"click_tracker":1,"recruiting":1,"faq":1,"venues":1,"genre":1,"listings":6,"experiential":1,"venue concerts":1,"mapping":5,"cleanup":1,"daily commission email":1,"super-bowl-ticket-tracker":1,"git hooks":1,"emails":5,"elasticsearch":1,"cartographer":4,"cdn":1,"super bowl":4,"ticket prices":2,"facebook":7,"venue":3,"maps":16,"static":4,"jobs":3,"lin":2,"checkout api":1,"map admin":4,"jerry":5,"services":2,"ticketcity":1,"signup":1,"deploy":2,"sg transactions":2,"tracker":4,"city page":1,"new relic":1,"adq":1,"biz dev":2,"cities":1,"sign up":1,"datawarehouse":1,"ticket evolution":1,"error pages":1,"sglib":4,"inventory":1,"marketing":7,"tracking":3,"new team":12,"cloud-vm":1,"seating":3,"new ga":2,"deal quality":5,"support":1,"newrelic":2,"documentation":1,"team/show":3,"djjob":4,"pagerduty":1,"market_coverage":1,"event page":2,"event/show":1,"telecharge":3,"standup":1,"newsies":2,"redis":1,"santamaria":7,"opensource":1,"apps":1,"nav":2,"asset-bundling":1,"category":6,"map":3,"sandcrab/apollo":1,"manbearpig":2,"debt":9,"passbook":1,"sandcrab":4,"service ingestion":5,"graphite":4,"style guide":1,"sg-hubot":1,"meta":1,"styleguide":1,"ux":2,"home":1,"symphony":1,"esat":2,"vfs images":1,"old/new team":1,"google maps":1,"nro":18,"recommendations":3,"new team/show":1,"fanstats":1,"event listing":1,"cronq":1,"leaflet":3,"ops-alert":1,"markers":1,"tests":3,"commission email":1,"navigation":1,"new core":2,"logging":1,"teamband":1,"brokerlogos":1,"performance":2,"sgcli":3,"docs":2,"sgteam":1,"twitter":1,"sglightbox":1,"login":1,"notes":1,"service":1,"keyboard":1,"fortune":2,"subscriptions":1,"alert":2,"https":2,"hudsucker":1,"seatview parents":1,"ssl":1,"olark":1,"seat views":1,"nagini":2,"sg direct":1,"pr email":1,"testing":2,"microdata":1,"retina":2,"price page":1,"sixpack":1,"routing":1,"djjob-amqp":1,"pricing":1,"navbar":1,"matchup":1,"ga event page":3,"growth":1,"mbp":2,"bing":3,"css":1,"concert":4,"gis":7,"map-admin":1,"landing pages":1,"fb":1,"mat":1,"click":1,"statsd":1,"seatgeek-vm":1,"seo-admin":2,"normalization":1,"symfony":1,"caysh":2,"google analytics":1,"logs":1,"primary":1,"logstash":1,"festivals":1,"general":1,"teamshow":1,"issues":1,"pingdom":1,"amqp":1,"oauth":1,"musicbrainz":1,"cron":1,"team / event":1,"map config":1,"privacy":1,"mysql":1}'

  def initialize(repo, client)
    @categories = []
    @category_hash = {}
    @start = 0

    open_issues_object = []
    @open_issues = client.issues(repo, :state => "open")
    parse_categories
  end

  def self.categories
    # return @category_hash
    return @@categories
  end

  def parse_categories
    @open_issues.each do |issue|
      title = issue.title
      bracket_index = title.index("]")
      if bracket_index
        category = title.slice(0..bracket_index.to_i)
        clean_category = category.delete('[]').downcase
        add_category(clean_category)
      else 
        claen_category = ""
      end
    end
  end

  def add_category(category)
    if !@category_hash[category]
      @categories << category
      @category_hash[category] = 1
    else 
      @category_hash[category] = @category_hash[category] + 1
    end
  end

end