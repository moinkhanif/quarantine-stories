# frozen_string_literal: true

# Quarantine Stories — Seed Data 🌟
# Adorable, wholesome, and funny things people did during quarantine.
# Run with: bundle exec rake db:seed

puts "🌱 Seeding Quarantine Stories..."

# ── Categories ──────────────────────────────────────────

categories = {
  "Baking"      => { priority: 1 },
  "Hobbies"     => { priority: 2 },
  "Home Life"   => { priority: 3 },
  "Zoom Life"   => { priority: 4 },
  "Wellness"    => { priority: 5 },
}

created_categories = {}
categories.each do |name, attrs|
  cat = Category.find_or_create_by!(name: name) do |c|
    c.priority = attrs[:priority]
  end
  created_categories[name] = cat
  puts "  📂 Category: #{name}"
end

# ── Default Author ─────────────────────────────────────

author = User.find_or_create_by!(name: "Storyteller")

# ── Articles ────────────────────────────────────────────

articles = [
  {
    title: "The Great Banana Bread Obsession 🍌",
    body: <<~BODY.squish,
      It started with three overripe bananas on the counter. Within a week,
      I'd made four loaves of banana bread, discovered my great-grandmother's
      secret recipe, and traded two loaves for a roll of toilet paper.
      My kitchen smelled like a bakery 24/7. No regrets.
    BODY
    category: "Baking",
    image_url: "https://picsum.photos/seed/banana/800/600",
  },
  {
    title: "I Started a Sourdough Starter Named Doughvid 🥖",
    body: <<~BODY.squish,
      His name is Doughvid. I feed him every morning. He has his own Instagram
      (16 followers — mostly my mom). I talk to him more than I talk to humans.
      Is this my life now? Yes. Yes it is.
    BODY
    category: "Baking",
    image_url: "https://picsum.photos/seed/sourdough/800/600",
  },
  {
    title: "My Plants Have Names Now 🪴",
    body: <<~BODY.squish,
      I went from zero houseplants to thirty-seven in three months. Ferny,
      Spike, Petunia, and thirty-four others. I water them on a schedule,
      talk to them about my day, and cried when Ferny got spider mites.
      My flat is a jungle now. I've never been happier.
    BODY
    category: "Hobbies",
    image_url: "https://picsum.photos/seed/plants/800/600",
  },
  {
    title: "The 1000-Piece Puzzle That Took 3 Weeks 🧩",
    body: <<~BODY.squish,
      It was supposed to be a "fun weekend project."Day 1: confidence.
      Day 3: the edge pieces are done! Day 7: I've sorted pieces by colour
      for the fifth time. Day 14: my dining table no longer exists.
      Day 21: FINISHED. Immediately bought another one.
    BODY
    category: "Hobbies",
    image_url: "https://picsum.photos/seed/puzzle/800/600",
  },
  {
    title: "I Learned to Paint. I'm Not Good. I Don't Care. 🎨",
    body: <<~BODY.squish,
      Bob Ross made it look so easy. Three months later, I have seventeen
      paintings of "happy little trees" that look more like sad little
      broccoli stalks. But you know what? Creating something — anything —
      felt incredible. My fridge has never been more decorated.
    BODY
    category: "Hobbies",
    image_url: "https://picsum.photos/seed/paint/800/600",
  },
  {
    title: "We Adopted a Cat Named Quaran-tina 🐱",
    body: <<~BODY.squish,
      She was a shelter cat who needed a home. I was a human who needed
      company. Now she sits on my laptop during every Zoom call, judges my
      life choices, and has taken over 70% of my bed. Best decision ever.
    BODY
    category: "Home Life",
    image_url: "https://picsum.photos/seed/cat/800/600",
  },
  {
    title: "The Toilet Paper Chronicles 🧻",
    body: <<~BODY.squish,
      I didn't panic-buy. I really didn't. But then my neighbour texted me
      a photo of her 24-roll tower and something snapped. I now have forty
      rolls under my bed. It's been two years. I'm still working through them.
      Send help. And maybe some tissues.
    BODY
    category: "Home Life",
    image_url: "https://picsum.photos/seed/toiletpaper/800/600",
  },
  {
    title: "Zoom Bloopers: The Compilation 💻",
    body: <<~BODY.squish,
      I've accidentally: muted myself for 20 minutes while giving a
      presentation, unmuted during a "private" rant about my boss (it was
      actually my boss), appeared in my pyjama top + formal bottoms
      combo, and had my cat walk across my keyboard mid-sentence.
      We've all been there.
    BODY
    category: "Zoom Life",
    image_url: "https://picsum.photos/seed/zoom/800/600",
  },
  {
    title: "Haircuts at Home: A Tragedy in 3 Acts ✂️",
    body: <<~BODY.squish,
      Act One: confidence. I can do this. How hard can it be?
      Act Two: realisation. Oh no. Oh no no no.
      Act Three: acceptance. Hats are now my entire personality.
      I wore a beanie to a wedding. No regrets.
    BODY
    category: "Zoom Life",
    image_url: "https://picsum.photos/seed/haircut/800/600",
  },
  {
    title: "I Started Running. Jogging. Walking Briskly. 🏃",
    body: <<~BODY.squish,
      Day 1: made it to the end of the street before stopping.
      Day 30: made it around the block without dying.
      Day 90: ran 5K. Cried at the finish line (which was my front door).
      The fresh air, the quiet streets, the waves from neighbours —
      it saved my sanity during those months.
    BODY
    category: "Wellness",
    image_url: "https://picsum.photos/seed/running/800/600",
  },
  {
    title: "Zoom Yoga: I Fell Off My Mattress 🧘",
    body: <<~BODY.squish,
      "Tree pose" they said. "It's relaxing" they said. My phone recording
      the session caught the entire thing: the wobble, the flail, the slow-motion
      tumble off my yoga mat (which was just a towel on a mattress).
      The instructor asked if I was okay. I said yes. We both knew it was a lie.
    BODY
    category: "Wellness",
    image_url: "https://picsum.photos/seed/yoga/800/600",
  },
]

articles.each do |attrs|
  category = created_categories[attrs[:category]]
  article = Article.find_or_create_by!(title: attrs[:title]) do |a|
    a.body = attrs[:body]
    a.category = category
    a.user = author
    a.image_url = attrs[:image_url]
  end
  puts "  📝 Article: #{article.title[0..50]}..."
end

puts ""
puts "✨ Done! #{Category.count} categories, #{Article.count} articles, #{User.count} user."
