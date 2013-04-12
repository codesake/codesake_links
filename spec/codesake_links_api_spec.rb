require 'spec_helper'
include WebMock::API

describe "The API for Codesake Links" do
  it "returns an array with a single / if the robots.txt contains only Allow: /" do
    stub_request(:get, "http://www.test.com/robots.txt").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status=>200, :body=>"User-agent: *\nAllow: /", :headers=>{})

    ret = Codesake::Links::Api.robots("http://www.test.com")
    ret[:status].should           == :OK
    ret[:allow_list].size.should  == 1
    ret[:allow_list].should       == [ '/' ]
  end

  it "returns an array with a single / if the robots.txt contains only Allow: / for an HTTPS site" do
    stub_request(:get, "http://www.test.com:443/robots.txt").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status=>200, :body=>"User-agent: *\nAllow: /", :headers=>{})

    ret = Codesake::Links::Api.robots("https://www.test.com")
    ret[:status].should           == :OK
    ret[:allow_list].size.should  == 1
    ret[:allow_list].should       == [ '/' ]
  end


  it "can handle an input without the protocol if target talks HTTP" do
    stub_request(:get, "http://www.test.com/robots.txt").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status=>200, :body=>"User-agent: *\nAllow: /", :headers=>{})

    ret = Codesake::Links::Api.robots("www.test.com")
    ret[:status].should           == :OK
    ret[:allow_list].size.should  == 1
    ret[:allow_list].should       == [ '/' ]
  end


  it "can't handle an input without the protocol if target talks *only* HTTPS" do
    stub_request(:get, "http://www.test.com:443/robots.txt").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status=>200, :body=>"User-agent: *\nAllow: /", :headers=>{})

    ret = Codesake::Links::Api.robots("www.test.com")
    ret[:status].should           == :KO
  end

  it "returns a list of disallowed URLs" do
    stub_request(:get, "http://www.test.com/robots.txt").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status=>200, :body=>"User-agent: *\nAllow: /\nDisallow: /private\nDisallow: /cgi-bin\nDisallow: /a-secret-dir", :headers=>{})

    ret = Codesake::Links::Api.robots("www.test.com")
    ret[:disallow_list].size.should     == 3
    ret[:disallow_list].should          == [ '/private', '/cgi-bin', '/a-secret-dir' ]

  end

end
