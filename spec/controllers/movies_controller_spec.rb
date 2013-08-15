require 'spec_helper'
 
describe MoviesController do
  # describe 'searching TMDb' do
  #   before :each do
  #     @fake_results = [mock('movie1'), mock('movie2')]
  #   end
  #   it 'should call the model method that performs TMDb search' do
  #     Movie.should_receive(:find_in_tmdb).with('hardware').
  #       and_return(@fake_results)
  #     post :search_tmdb, {:search_terms => 'hardware'}
  #   end
  #   describe 'after valid search' do
  #     before :each do
  #       Movie.stub(:find_in_tmdb).and_return(@fake_results)
  #       post :search_tmdb, {:search_terms => 'hardware'}
  #     end
  #     it 'should select the Search Results template for rendering' do
  #       response.should render_template('search_tmdb')
  #     end
  #     it 'should make the TMDb search results available to that template' do
  #       assigns(:movies).should == @fake_results
  #     end
  #   end
  # end
  describe 'searching same director' do
    it 'should call the model method that performs same director search' do
    end
    describe 'after valid search' do
      it 'should select the Search Results template for rendering' do
      end
      it 'should make the same director search results available to that template' do
      end
    end
  end
end