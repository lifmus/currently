class CleanUsernameValidator < ActiveModel::EachValidator

  #https://gist.github.com/caseyohara/1453705
  RESERVED_USERNAMES = [
     'stacks', 'imulus', 'github', 'twitter', 'facebook', 'google', 'apple', 'about', 'account',
     'activate', 'add', 'admin', 'administrator', 'api', 'app', 'apps', 'archive', 'archives',
     'auth', 'blog', 'cache', 'cancel', 'careers', 'cart', 'changelog', 'checkout', 'codereview',
     'compare', 'config', 'configuration', 'connect', 'contact', 'create', 'delete', 'direct_messages',
     'documentation', 'download', 'downloads', 'edit', 'email', 'employment', 'enterprise', 'faq',
     'favorites', 'feed', 'feedback', 'feeds', 'fleet', 'fleets', 'follow', 'followers', 'following',
     'friend', 'friends', 'gist', 'group', 'groups', 'help', 'home', 'hosting', 'hostmaster', 'idea',
     'ideas', 'index', 'info', 'invitations', 'invite', 'is', 'it', 'job', 'jobs', 'json', 'language',
     'languages', 'lists', 'login', 'logout', 'logs', 'mail', 'map', 'maps', 'mine', 'mis', 'news',
     'oauth', 'oauth_clients', 'offers', 'openid', 'order', 'orders', 'organizations', 'plans',
     'popular', 'post', 'postmaster', 'privacy', 'projects', 'put', 'recruitment', 'register',
     'remove', 'replies', 'root', 'rss', 'sales', 'save', 'search', 'security', 'sessions', 'settings',
     'shop', 'signup', 'sitemap', 'ssl', 'ssladmin', 'ssladministrator', 'sslwebmaster', 'status', 
     'stories', 'styleguide', 'subscribe', 'subscriptions', 'support', 'sysadmin', 'sysadministrator', 
     'terms', 'tour', 'translations', 'trends', 'unfollow', 'unsubscribe', 'update', 'url', 'user', 
     'weather', 'webmaster', 'widget', 'widgets', 'wiki', 'ww', 'www', 'wwww', 'xfn', 'xml', 'xmpp', 
     'yaml', 'yml', 'chinese', 'mandarin', 'spanish', 'english', 'bengali', 'hindi', 'portuguese', 
     'russian', 'japanese', 'german', 'wu', 'javanese', 'korean', 'french', 'vietnamese', 'telugu', 
     'chinese', 'marathi', 'tamil', 'turkish', 'urdu', 'min-nan', 'jinyu', 'gujarati', 'polish', 
     'arabic', 'ukrainian', 'italian', 'xiang', 'malayalam', 'hakka', 'kannada', 'oriya', 'panjabi', 
     'sunda', 'panjabi', 'romanian', 'bhojpuri', 'azerbaijani', 'farsi', 'maithili', 'hausa', 'arabic', 
     'burmese', 'serbo-croatian', 'gan', 'awadhi', 'thai', 'dutch', 'yoruba', 'sindhi', 'ac', 'ad', 
     'ae', 'af', 'ag', 'ai', 'al', 'am', 'an', 'ao', 'aq', 'ar', 'as', 'at', 'au', 'aw', 'ax', 'az', 
     'ba', 'bb', 'bd', 'be', 'bf', 'bg', 'bh', 'bi', 'bj', 'bm', 'bn', 'bo', 'br', 'bs', 'bt', 'bv', 
     'bw', 'by', 'bz', 'ca', 'cc', 'cd', 'cf', 'cg', 'ch', 'ci', 'ck', 'cl', 'cm', 'cn', 'co', 'cr', 
     'cs', 'cu', 'cv', 'cx', 'cy', 'cz', 'dd', 'de', 'dj', 'dk', 'dm', 'do', 'dz', 'ec', 'ee', 'eg', 
     'eh', 'er', 'es', 'et', 'eu', 'fi', 'fj', 'fk', 'fm', 'fo', 'fr', 'ga', 'gb', 'gd', 'ge', 'gf', 
     'gg', 'gh', 'gi', 'gl', 'gm', 'gn', 'gp', 'gq', 'gr', 'gs', 'gt', 'gu', 'gw', 'gy', 'hk', 'hm', 
     'hn', 'hr', 'ht', 'hu', 'id', 'ie', 'il', 'im', 'in', 'io', 'iq', 'ir', 'is', 'it', 'je', 'jm', 
     'jo', 'jp', 'ke', 'kg', 'kh', 'ki', 'km', 'kn', 'kp', 'kr', 'kw', 'ky', 'kz', 'la', 'lb', 'lc', 
     'li', 'lk', 'lr', 'ls', 'lt', 'lu', 'lv', 'ly', 'ma', 'mc', 'md', 'me', 'mg', 'mh', 'mk', 'ml', 
     'mm', 'mn', 'mo', 'mp', 'mq', 'mr', 'ms', 'mt', 'mu', 'mv', 'mw', 'mx', 'my', 'mz', 'na', 'nc', 
     'ne', 'nf', 'ng', 'ni', 'nl', 'no', 'np', 'nr', 'nu', 'nz', 'om', 'pa', 'pe', 'pf', 'pg', 'ph', 
     'pk', 'pl', 'pm', 'pn', 'pr', 'ps', 'pt', 'pw', 'py', 'qa', 're', 'ro', 'rs', 'ru', 'rw', 'sa', 
     'sb', 'sc', 'sd', 'se', 'sg', 'sh', 'si', 'sj', 'sk', 'sl', 'sm', 'sn', 'so', 'sr', 'ss', 'st', 
     'su', 'sv', 'sy', 'sz', 'tc', 'td', 'tf', 'tg', 'th', 'tj', 'tk', 'tl', 'tm', 'tn', 'to', 'tp', 
     'tr', 'tt', 'tv', 'tw', 'tz', 'ua', 'ug', 'uk', 'us', 'uy', 'uz', 'va', 'vc', 've', 'vg', 'vi', 
     'vn', 'vu', 'wf', 'ws', 'ye', 'yt', 'yu', 'za', 'zm', 'zw'
  ]
 
  def validate_each(object, attribute, value)
    if RESERVED_USERNAMES.include?(value)
      object.errors[attribute] << (options[:message] || 'is not a valid name')
    end
  end
end