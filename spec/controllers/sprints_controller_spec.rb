require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintsController do

  def mock_sprint(stubs={})
    @mock_sprint ||= mock_model(Sprint, stubs)
  end

  describe "GET index" do
    it "assigns all sprints as @sprints" do
      Sprint.should_receive(:find).with(:all, :order => "title").and_return([mock_sprint])
      get :index
      assigns[:sprints].should == [mock_sprint]
    end
  end

  describe "GET show" do
    it "assigns the requested sprint as @sprint" do
      Sprint.stub!(:find).with("37").and_return(mock_sprint)
      get :show, :id => "37"
      assigns[:sprint].should equal(mock_sprint)
    end
  end

  describe "GET new" do
    it "assigns a new sprint as @sprint" do
      Sprint.stub!(:new).and_return(mock_sprint)
      get :new
      assigns[:sprint].should equal(mock_sprint)
    end
  end

  describe "GET edit" do
    it "assigns the requested sprint as @sprint" do
      Sprint.stub!(:find).with("37").and_return(mock_sprint)
      get :edit, :id => "37"
      assigns[:sprint].should equal(mock_sprint)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created sprint as @sprint" do
        Sprint.stub!(:new).with({'these' => 'params'}).and_return(mock_sprint(:save => true))
        post :create, :sprint => {:these => 'params'}
        assigns[:sprint].should equal(mock_sprint)
      end

      it "redirects to the created sprint" do
        Sprint.stub!(:new).and_return(mock_sprint(:save => true))
        post :create, :sprint => {}
        response.should redirect_to(sprint_url(mock_sprint))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sprint as @sprint" do
        Sprint.stub!(:new).with({'these' => 'params'}).and_return(mock_sprint(:save => false))
        post :create, :sprint => {:these => 'params'}
        assigns[:sprint].should equal(mock_sprint)
      end

      it "re-renders the 'new' template" do
        Sprint.stub!(:new).and_return(mock_sprint(:save => false))
        post :create, :sprint => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested sprint" do
        Sprint.should_receive(:find).with("37").and_return(mock_sprint)
        mock_sprint.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :sprint => {:these => 'params'}
      end

      it "assigns the requested sprint as @sprint" do
        Sprint.stub!(:find).and_return(mock_sprint(:update_attributes => true))
        put :update, :id => "1"
        assigns[:sprint].should equal(mock_sprint)
      end

      it "redirects to the sprint" do
        Sprint.stub!(:find).and_return(mock_sprint(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(sprint_url(mock_sprint))
      end
    end

    describe "with invalid params" do
      it "updates the requested sprint" do
        Sprint.should_receive(:find).with("37").and_return(mock_sprint)
        mock_sprint.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :sprint => {:these => 'params'}
      end

      it "assigns the sprint as @sprint" do
        Sprint.stub!(:find).and_return(mock_sprint(:update_attributes => false))
        put :update, :id => "1"
        assigns[:sprint].should equal(mock_sprint)
      end

      it "re-renders the 'edit' template" do
        Sprint.stub!(:find).and_return(mock_sprint(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested sprint" do
      Sprint.should_receive(:find).with("37").and_return(mock_sprint)
      mock_sprint.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the sprints list" do
      Sprint.stub!(:find).and_return(mock_sprint(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(sprints_url)
    end
  end
  
  describe "GET sprint workload" do
    it "redirect to the sprint workload page" do
      Sprint.stub!(:find).with("37").and_return(mock_sprint)
      get :workload, :id => "37"
      assigns[:sprint].should equal(mock_sprint)
    end
  end

end
