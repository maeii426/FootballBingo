# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_users = [{:name => 'admin', :email => 'admin@gmail.com', :password => '123456', :role => :admin},]
admin_users.each do |admin_user|
    User.create!(admin_user)
end

general_users = [{:name => 'Frank Flanigan', :email => 'whoop606super@gmail.com', :password => '123123', :role => :user},]
general_users.each do |general_user|
    User.create!(general_users)
end

games = [{:game_name => 'TAMU10', :date => '24-Nov-2018', :instant_winner => 'Jeffrey Hoberman', :whoop_winner => 'Frank Flanigan',:notify_by_email => 0},
    	 {:game_name => 'TAMU12', :date => '10-Nov-2018', :notify_by_email => 0},
	]

games.each do |game|
  Game.create!(game)
end

# translations = [{:tag => 'penalties_yds', :words => 'Number of penalty yards'},
#     	 {:tag => 'firstdowns_no', :words => 'Total first downs'},
#     	 {:tag => 'totals_totoff_yards', :words => 'Total offensive yards gained'},
#     	 {:tag => 'fg_made', :words => 'Number of field goals made'},
#     	 {:tag => 'empty', :words => 'Some condition here'},
#   	 ]

# translations.each do |translation|
#   Translation.create!(translation)
# end

# chips = [{:chip_id => '1', :translation_id => '1', :argument => '>', :value => 100},
#     	 {:chip_id => '2', :translation_id => '2', :argument => '>', :value => 30},
#     	 {:chip_id => '3', :translation_id => '3', :argument => '>', :value => 500},
#     	 {:chip_id => '4', :translation_id => '4', :argument => '>', :value => 2},
#     	 {:chip_id => '5', :translation_id => '5', :argument => '>', :value => 0},
#   	 ]

@trans = Translation.create!({:tag => 'penalties_yds', :words => 'Number of penalty yards'})
@trans.chips.create(:argument => '>', :value => 100)

@trans = Translation.create!({:tag => 'firstdowns_no', :words => 'Total first downs'})
@trans.chips.create(:argument => '>', :value => 30)

@trans = Translation.create!({:tag => 'totals_totoff_yards', :words => 'Total offensive yards gained'})
@trans.chips.create!(:argument => '>', :value => 500)

@trans = Translation.create!({:tag => 'fg_made', :words => 'Number of field goals made'})
@trans.chips.create!(:argument => '>', :value => 2)

@trans = Translation.create!({:tag => 'empty', :words => 'Some condition here'})
@trans.chips.create!(:argument => '>', :value => 0)

translations = [
{:tag => 'firstdowns_rush', :words => 'Total rushing first downs'},
{:tag => 'firstdowns_pass', :words => 'Total passing first downs'},
{:tag => 'firstdowns_penalty', :words => 'Total penalty first downs'},

{:tag => 'penalties_no', :words => 'Total penalties'},
{:tag => 'penalties_yds', :words => 'Total penalty yards'},

{:tag => 'conversions_thirdconv', :words => 'Third down conversions'},
{:tag => 'conversions_thirdatt', :words => 'Third down attempts'},
{:tag => 'conversions_fourthconv', :words => 'Fourth down conversions'},
{:tag => 'conversions_fourthatt', :words => 'Fourth down attempts'},

{:tag => 'fumbles_no', :words => 'Total fumbles'},
{:tag => 'fumbles_lost', :words => 'Total fumbles lost'},

{:tag => 'misc_yds', :words => '...'},
{:tag => 'misc_top', :words => '...'},
{:tag => 'misc_ona', :words => '...'},
{:tag => 'misc_onm', :words => '...'},
{:tag => 'misc_ptsto', :words => '...'},

{:tag => 'redzone_att', :words => 'Total redzone attempts'},
{:tag => 'redzone_scores', :words => 'Total redzone scores'},
{:tag => 'redzone_points', :words => 'Total redzone points'},
{:tag => 'redzone_tdrush', :words => 'Total redzone rushing touchdowns'},
{:tag => 'redzone_tdpass', :words => 'Total redzone passing touchdowns'},
{:tag => 'redzone_fgmade', :words => 'Total redzone field goals made'},
{:tag => 'redzone_endfga', :words => '...'},
{:tag => 'redzone_enddowns', :words => '...'},
{:tag => 'redzone_endint', :words => '...'},
{:tag => 'redzone_endfumb', :words => '...'},
{:tag => 'redzone_endhalf', :words => '...'},
{:tag => 'redzone_endgame', :words => '...'},

{:tag => 'rush_att', :words => 'Total rushing attempts'},
{:tag => 'rush_yds', :words => 'Total rushing yards'},
{:tag => 'rush_gain', :words => 'Total rushing gained'},
{:tag => 'rush_loss', :words => 'Total rushing loss'},
{:tag => 'rush_td', :words => 'Total rushing touchdowns'},
{:tag => 'rush_long', :words => 'Longest rush'},

{:tag => 'pass_comp', :words => 'Total passing completions'},
{:tag => 'pass_att', :words => 'Total passing attempts'},
{:tag => 'pass_int', :words => 'Total passing interceptions thrown'},
{:tag => 'pass_yds', :words => 'Total passing yards'},
{:tag => 'pass_td', :words => 'Total passing touchdowns'},
{:tag => 'pass_long', :words => 'Longest pass'},
{:tag => 'pass_sacks', :words => 'Total passing sacks'},
{:tag => 'pass_sackyds', :words => 'Total passing sacks yards'},

{:tag => 'rcv_no', :words => 'Total receptions'},
{:tag => 'rcv_yds', :words => 'Total receiving yards'},
{:tag => 'rcv_td', :words => 'Total receiving touchdowns'},
{:tag => 'rcv_long', :words => 'Longest receptions'},

{:tag => 'punt_no', :words => 'Total punts'},
{:tag => 'punt_yds', :words => 'Total punting yards'},
{:tag => 'punt_long', :words => 'Longest punt'},
{:tag => 'punt_blkd', :words => 'Total blocked punts'},
{:tag => 'punt_tb', :words => 'Total punting touchdowns'},
{:tag => 'punt_fc', :words => 'Total punting fair catches'},
{:tag => 'punt_plus50', :words => 'Total punts outside the 50-yard line'},
{:tag => 'punt_inside20', :words => 'Total punts down inside the 20 yard line'},
{:tag => 'punt_avg', :words => 'Total punting average'},

{:tag => 'ko_no', :words => 'Total kickoffs'},
{:tag => 'ko_yds', :words => 'Total kickoff yards'},
{:tag => 'ko_ob', :words => 'Total kickoffs that go out of bounds'},
{:tag => 'ko_tb', :words => 'Total kickoffs touchbacks'},
{:tag => 'ko_fcyds', :words => 'Total kickoffs fair catches yards'},

{:tag => 'fg_made', :words => 'Total field goals made'},
{:tag => 'fg_att', :words => 'Total field goals attempts'},
{:tag => 'fg_long', :words => 'Longest field goal'},
{:tag => 'fg_blkd', :words => 'Total blocked field goals'},

{:tag => 'pat_kickatt', :words => 'Total attempts after kicking touchdown'},
{:tag => 'pat_kickmade', :words => 'Total points made after kicking touchdown'},
{:tag => 'pat_passatt', :words => 'Total attempts after passing touchdown'},
{:tag => 'pat_passmade', :words => 'Total points made after passing touchdown'},
{:tag => 'pat_rcvatt', :words => 'Total attempts after receiving touchdown'},
{:tag => 'pat_rcvmade', :words => 'Total points made after receiving touchdown'},

{:tag => 'defense_tackua', :words => 'Total solo tackles'},
{:tag => 'defense_tacka', :words => 'Total asst tackles'},
{:tag => 'defense_tot_tack', :words => 'Total tackles'},
{:tag => 'defense_tflua', :words => 'Total solo tackles for loss'},
{:tag => 'defense_tfla', :words => 'Total asst tackles for loss'},
{:tag => 'defense_tflyds', :words => 'Total yards lost from tackles'},
{:tag => 'defense_sacks', :words => 'Total tackle sacks'},
{:tag => 'defense_sackyds', :words => 'Total yards lost from sacks'},
{:tag => 'defense_brup', :words => '...'},
{:tag => 'defense_qbh', :words => '...'},
{:tag => 'defense_ff', :words => 'Total forced fumbles'},
{:tag => 'defense_fr', :words => 'Total fumble recoveries'},
{:tag => 'defense_fryds', :words => 'Total fumble return yards'},

{:tag => 'kr_no', :words => 'Total kick recoveries'},
{:tag => 'kr_yds', :words => 'Total kick recovery yards'},
{:tag => 'kr_td', :words => 'Total kick recoveries touchdowns'},
{:tag => 'kr_long', :words => 'Longest kick recovery'},

{:tag => 'pr_no', :words => 'Total ... recoveries'},
{:tag => 'pr_yds', :words => 'Total ...  yards'},
{:tag => 'pr_td', :words => 'Total ... recoveries touchdowns'},
{:tag => 'pr_long', :words => 'Longest ... recovery'},

{:tag => 'fr_no', :words => 'Total fumble recoveries'},
{:tag => 'fr_yds', :words => 'Total fumble return yards'},
{:tag => 'fr_td', :words => 'Total fumble recoveries touchdowns'},
{:tag => 'fr_long', :words => 'Longest fumble recovery'},

{:tag => 'scoring_td', :words => 'Total touchdowns scored'},
{:tag => 'scoring_fg', :words => 'Total field goals scored'},
{:tag => 'scoring_patkick', :words => 'Total patkicks scored'},
{:tag => 'scoring_patrcv', :words => 'Total pat receptions scored'},
]

translations.each do|tran|
    @t = Translation.create!(tran)
    @t.save
end
# chips.each do |chip|
#   Chip.create!(chip)
# end

cards = [{:user_id => '1'},
    ]

cards.each do|card|
    @card = Card.create!(card)
    #@card.chip_ids = card.chip_ids < chip.id
    # @card.chip_ids = [1,2,3,4,5,5,5,5,5]
    @card.save
end

    # chip.card_ids = chip.card_ids < card.id
    # chip.save

card_chips = [{:card_id => '1', :chip_id => '1'},
  {:card_id => '1', :chip_id => '2'},
  {:card_id => '1', :chip_id => '3'},
  {:card_id => '1', :chip_id => '4'},
  {:card_id => '1', :chip_id => '5'},
  {:card_id => '1', :chip_id => '5'},
  {:card_id => '1', :chip_id => '5'},
  {:card_id => '1', :chip_id => '5'},
  {:card_id => '1', :chip_id => '5'},
    ]

card_chips.each do|cc|
    CardChip.create!(cc)
end
