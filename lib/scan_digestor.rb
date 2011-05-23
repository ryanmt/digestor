#!/usr/bin/env ruby
class Digestor
	DEFAULTS = {:missed_cleavages => 0, :minimum_length => 1}
	def initialize(enzyme)
		@regexp = Enzymes[enzyme.downcase]
	end
	def digest(string, opts = {}) # Returns an array of chomped sequences
	  opts = DEFAULTS.merge(opts)
		string.upcase!
		holder = string.scan(@regexp).flatten.compact
		outs = holder
		if :missed_cleavages != 0
			outs << (1..(opts[:missed_cleavages]+1)).map do |cons|
				holder.each_cons(cons).map(&:join)
			end
		end
		outs = outs.flatten.map{|a| a if a.length >= opts[:minimum_length]}.compact.uniq
	end

	Enzymes = {'trypsin' => Regexp.new('(\D*?[KR])(?=[^P])|([^P].*?\b)'), 
	"trypsin/p" => Regexp.new('(\D*?[KR])|(.*?\b)'), 
	"arg-c" => Regexp.new('(\w+?[R])(?=[^P])|([^P].*?\b)'), 
	"asp-n" => Regexp.new('\w+?(?=[BD]|$)'),
	"chymotrypsin" => Regexp.new('(\D*?[FYWL])(?=[^P])|([^P].*?\b)'), 
	"cnbr+trypsin" => Regexp.new('(\D*?(?:(?:[KR](?=[^P]))|[M]))|(.*?\b)')
	}

end

