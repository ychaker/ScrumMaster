require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "sprints", :action => "index").should == "/sprints"
    end

    it "maps #new" do
      route_for(:controller => "sprints", :action => "new").should == "/sprints/new"
    end

    it "maps #show" do
      route_for(:controller => "sprints", :action => "show", :id => "1").should == "/sprints/1"
    end

    it "maps #edit" do
      route_for(:controller => "sprints", :action => "edit", :id => "1").should == "/sprints/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "sprints", :action => "create").should == {:path => "/sprints", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "sprints", :action => "update", :id => "1").should == {:path =>"/sprints/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "sprints", :action => "destroy", :id => "1").should == {:path =>"/sprints/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/sprints").should == {:controller => "sprints", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/sprints/new").should == {:controller => "sprints", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/sprints").should == {:controller => "sprints", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/sprints/1").should == {:controller => "sprints", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/sprints/1/edit").should == {:controller => "sprints", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/sprints/1").should == {:controller => "sprints", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/sprints/1").should == {:controller => "sprints", :action => "destroy", :id => "1"}
    end
  end
end
