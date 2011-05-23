require 'spec_helper'


describe "Digestor" do
	before do 
		@seq = "YESTESTTHISDECLARATIVESENTENCEKSCIENTISTLETSCALLEMFINISHEDYALL" #Thanks John
		@seq2 = "MKWVTFISLLLLFSSAYSRGVFRRDTHKSEIAHRFKDLGEEHFKGLVLIAFSQYLQQCPFDEHVKLVNELTEFAKTCVADESHAGCEKSLHTLFGDELCKVASLRETYGDMADCCEKQEPERNECFLSHKDDSPDLPKLKPDPNTLCDEFKADEKKFWGKYLYEIARRHPYFYAPELLYYANKYNGVFQECCQAEDKGACLLPKIETMREKVLASSARQRLRCASIQKFGERALKAWSVARLSQKFPKAEFVEVTKLVTDLTKVHKECCHGDLLECADDRADLAKYICDNQDTISSKLKECCDKPLLEKSHCIAEVEKDAIPENLPPLTADFAEDKDVCKNYQEAKDAFLGSFLYEYSRRHPEYAVSVLLRLAKEYEATLEECCAKDDPHACYSTVFDKLKHLVDEPQNLIKQNCDQFEKLGEYGFQNALIVRYTRKVPQVSTPTLVEVSRSLGKVGTRCCTKPESERMPCTEDYLSLILNRLCVLHEKTPVSEKVTKCCTESLVNRRPCFSALTPDETYVPKAFDEKLFTFHADICTLPDTEKQIKKQTALVELLKHKPKATEEQLKTVMENFVAFVDKCCAADDKEACFAVEGPKLVVSTQTALA"
	end
# This iterates throught the conditions (each enzyme) and makes for pretty output
  %w(Trypsin Trypsin/P Arg-C Asp-N Chymotrypsin CNBR+Trypsin).each do |enzyme|
		it "digests with #{enzyme}" do
			it 'handles both 0 and 1 missed cleavage(s) as determined by result parsing' do
				d = Digestor.new(enzyme)
				[@seq, @seq2].each do |sequence|
					[0,1].each do |missed_cleavages|
						result = d.digest(@seq, missed_cleavages: missed_cleavages)
						lengths = result.map do |peptide|
							arr = d.digest(peptide)
							arr.length
						end
						lengths.sort.last.should.equal (missed_cleavages + 1)
					end
				end # Sequence loop
			end # handles variable missed cleavages
			it "doesn't fail the test case written to check the output\n" do 
				it "\thandles the 'short_sequence'" do 
					d = Digestor.new(enzyme)
					test = case enzyme
						when "Trypsin"
							"ATIVESENTENCEK"
						when "Trypsin/P"
							"ATIVESENTENCEK"
						when "Arg-C"
							"ATIVESENTENCEKSCIENTISTLETSCALLEMFINISHEDYALL"
						when "Asp-N"
							"YESTESTTHIS"
						when "Chymotrypsin"
							"ARATIVESENTENCEKSCIENTISTL"
						when "CNBR+Trypsin"
							"YESTESTTHISDECLAR"
					end
					d.digest(@seq).index(test).nil?.should.equal false
				end # Short sequence
				it "\thandles the 'BSA' sequence" do 
					d = Digestor.new(enzyme)
					test = case enzyme
						when "Trypsin"
							"RPCFSALTPDETYVPK"
						when "Trypsin/P"
							"PCFSALTPDETYVPK"
						when "Arg-C"
							"ETYGDMADCCEKQEPER"
						when "Asp-N"
							"DESHAGCEKSLHTLFG"
						when "Chymotrypsin"
							"EECCAKDDPHACY"
						when "CNBR+Trypsin"
							"ETYGDM"
					end
					d.digest(@seq2).index(test).nil?.should.equal false
				end # BSA sequence
			end # it doesn't fail the test cases
		end # it digests 
	end # enzymes.each
end # Describe Digestor
