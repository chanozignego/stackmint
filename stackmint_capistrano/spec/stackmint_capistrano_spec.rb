require 'stackmint'

def as_file_lines template_result
  template_result.split(/\n/).map!(&:chomp).select do |line|
    !line.empty? && !line.match(/^# /)
  end
end

def split_as_sections template_result
  current_key = nil
  sections    = {}
  lines       = as_file_lines(template_result)
  lines.each do |line|
    if line.match /SECTION/
      current_key = ( line.gsub /### SECTION :/, "" ).to_sym
    else
      sections[current_key] ||= []
      sections[current_key] << line
    end
  end
  sections
end

describe Stackmint::Capistrano do
  describe Stackmint::Capistrano::CapfileTemplater do
    subject :templater do
      Stackmint::Capistrano::CapfileTemplater.new 
    end
    before :each do
      @sections = split_as_sections(templater.render!)
    end

    it "should work by default" do
      result = templater.render!
      lines = as_file_lines result
      result.should be_a(String)
    end

    context "databases" do
      context "should accept :postgres as database" do
        it "should require rails recipes" do
          @sections[:install_recipes].any? { |x| x.match(/stackmint.*capistrano.*postgresql/) }.should be_true
        end
      end
      context "should accept :mysql as database" do
        subject :templater do
          Stackmint::Capistrano::CapfileTemplater.new(database: :mysql)
        end
        it "should require rails recipes" do
          @sections[:install_recipes].any? { |x| x.match(/stackmint.*capistrano.*mysql/) }.should be_true
        end
      end
    end
  end
end
