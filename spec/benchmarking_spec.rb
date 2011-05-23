#!/usr/bin/env ruby

require 'benchmark'
require 'spec_helper'

seq2 = "MKWVTFISLLLLFSSAYSRGVFRRDTHKSEIAHRFKDLGEEHFKGLVLIAFSQYLQQCPFDEHVKLVNELTEFAKTCVADESHAGCEKSLHTLFGDELCKVASLRETYGDMADCCEKQEPERNECFLSHKDDSPDLPKLKPDPNTLCDEFKADEKKFWGKYLYEIARRHPYFYAPELLYYANKYNGVFQECCQAEDKGACLLPKIETMREKVLASSARQRLRCASIQKFGERALKAWSVARLSQKFPKAEFVEVTKLVTDLTKVHKECCHGDLLECADDRADLAKYICDNQDTISSKLKECCDKPLLEKSHCIAEVEKDAIPENLPPLTADFAEDKDVCKNYQEAKDAFLGSFLYEYSRRHPEYAVSVLLRLAKEYEATLEECCAKDDPHACYSTVFDKLKHLVDEPQNLIKQNCDQFEKLGEYGFQNALIVRYTRKVPQVSTPTLVEVSRSLGKVGTRCCTKPESERMPCTEDYLSLILNRLCVLHEKTPVSEKVTKCCTESLVNRRPCFSALTPDETYVPKAFDEKLFTFHADICTLPDTEKQIKKQTALVELLKHKPKATEEQLKTVMENFVAFVDKCCAADDKEACFAVEGPKLVVSTQTALA"
	Benchmark.bm(5) do |x|
		x.report ('Trypsin @ 0 missed cleavages (100 times)') do 
			100.times do 
				d = Digestor.new('trypsin')
				d.digest(seq2, :missed_cleavages => 0)
			end
		end
		x.report ('Trypsin @ 2 missed cleavages (100 times)') do 
			100.times do 
				d = Digestor.new('trypsin')
				d.digest(seq2, :missed_cleavages => 2)
			end
		end
		x.report ('Trypsin @ 0 missed cleavages (1000 times)') do 
			1000.times do 
				d = Digestor.new('trypsin')
				d.digest(seq2, :missed_cleavages => 0)
			end
		end
		x.report ('Trypsin @ 2 missed cleavages (1000 times)') do 
			1000.times do 
				d = Digestor.new('trypsin')
				d.digest(seq2, :missed_cleavages => 2)
			end
		end
		x.report ('Trypsin @ 0 missed cleavages (10000 times)') do 
			10000.times do 
				d = Digestor.new('trypsin')
				d.digest(seq2, :missed_cleavages => 0)
			end
		end
		x.report ('Trypsin @ 2 missed cleavages (10000 times)') do 
			10000.times do 
				d = Digestor.new('trypsin')
				d.digest(seq2, :missed_cleavages => 2)
			end
		end
		x.report ('Trypsin @ 8 missed cleavages (10000 times)') do 
			10000.times do 
				d = Digestor.new('trypsin')
				d.digest(seq2, :missed_cleavages => 8)
			end
		end

	end # Benchmark
