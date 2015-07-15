require 'spec_helper'

module Hubstats
  describe EventsHandler, :type => :model do
    context "PullRequestEvent" do
      let(:pull) {build(:pull_request)}
      let(:repo) {build(:repo)}
      let(:payload) {build(:pull_request_payload_hash)}

      subject {Hubstats::EventsHandler.new()}
      it 'should successfully route the event' do
        expect(subject).to receive(:pull_processor)
        subject.route(payload, payload[:type])
      end

      it 'should add labels to pull request' do
        allow(PullRequest).to receive(:create_or_update) {pull}
        allow(Repo).to receive(:where) {[repo,repo]}
        allow(GithubAPI).to receive(:get_labels_for_pull) {['low','high']}
        expect(pull).to receive(:add_labels).with(['low','high'])
        subject.route(payload, payload[:type])
      end
    end

    context "CommentEvent" do
      it 'should successfully route the event' do
        ehandler = EventsHandler.new()
        payload = build(:comment_payload_hash)
        expect(ehandler).to receive(:comment_processor)
        ehandler.route(payload, payload[:type])
      end

      it 'should successfully process the event' do
        ehandler = Hubstats::EventsHandler.new()
        payload = build(:comment_payload_hash)
        expect(Hubstats::Comment).to receive(:create_or_update)
        ehandler.route(payload, payload[:type])
      end

      it 'should successfully creates_or_updates the event' do
        ehandler = Hubstats::EventsHandler.new()
        payload = build(:comment_payload_hash)
        expect(ehandler.route(payload, payload[:type]).class).to eq(Hubstats::Comment)
      end
    end

    context "TeamEvent" do
      it 'should successfully route the team' do
        ehandler = EventsHandler.new()
        payload = build(:team_payload_hash)
        expect(ehandler).to receive(:team_processor)
        ehandler.route(payload, payload[:type])
      end

      it 'should successfully process the team' do
        ehandler = Hubstats::EventsHandler.new()
        payload = build(:team_payload_hash)
        expect(Hubstats::Team).to receive(:create_or_update)
        ehandler.route(payload, payload[:type])
      end

      it 'should successfully create_or_update the team' do
        ehandler = Hubstats::EventsHandler.new()
        payload = build(:team_payload_hash)
        expect(ehandler.route(payload, payload[:type]).class).to eq(Hubstats::Team)
      end
    end

  end
end
