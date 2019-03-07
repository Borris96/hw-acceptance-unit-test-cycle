require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    describe 'Find With Same Director' do
        
        it 'should show movies by this director' do
            fake_movie = double('movie', :title => 'Me', :director => 'Borris')              # Mock a fake movie whose director is Borris.
            expect(Movie).to receive(:find).with('1').and_return(fake_movie)                 # The id of the movie is 1
            fake_results = [double('movie1', :title => 'You', :director => 'Borris'),        # Mock two other fake movies whose director is also Borris.
            double('movie2', :title => 'He', :director => 'Borris')]
            expect(Movie).to receive(:find_same_director).with('1').and_return(fake_results) # By calling find_same_director it should return the two fake movies
            get :same_director, {:id => '1'}                                                 # Simulate getting results from the controller
            expect(response).to render_template('same_director')
        end
        
        it 'should raise an error if no director matches' do
            fake_movie = double('movie', :title => 'Me', :director => 'Borris')              # Mock a fake movie whose director is Borris.
            expect(Movie).to receive(:find).with('1').and_return(fake_movie) 
            allow(Movie).to receive(:find_same_director).and_raise(Movie::NoDirectorInformation)
            get :same_director, {:id => "1"}
            expect(response).to redirect_to(movies_path)
        end
        
    end
end