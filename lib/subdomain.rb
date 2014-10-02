class Subdomain
  def self.matches?(request)
    case request.subdomains.first
    when 'www', '', nil
      false
    else
      true
    end
  end
end
