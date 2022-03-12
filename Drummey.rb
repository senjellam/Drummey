use_osc "localhost", 4560


/ =================================================================== /
/ GLOBAL VALUES /

live_loop :getThreshold do
  use_real_time
  setThreshold = sync "/osc*/setThreshold"
  set :gThreshold, setThreshold[0]
end

live_loop :getAttack do
  use_real_time
  setAttack = sync "/osc*/setAttack"
  set :gAttack, setAttack[0]
end

live_loop :getRelease do
  use_real_time
  setRelease = sync "/osc*/setRelease"
  set :gRelease, setRelease[0]
end


/ =================================================================== /
/ FUSION DRUMS /

live_loop :fusionBass do
  use_real_time
  drumsFusion = sync "/osc*/drumsFusion"
  set :amp, drumsFusion[0]
  sample :drum_bass_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :fusionSnare do
  use_real_time
  drumsFusion = sync "/osc*/drumsFusion"
  set :amp, drumsFusion[1]
  sample :drum_snare_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :fusionTomTom1 do
  use_real_time
  drumsFusion = sync "/osc*/drumsFusion"
  set :amp, drumsFusion[2]
  sample :drum_tom_mid_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :fusionTomTom2 do
  use_real_time
  drumsFusion = sync "/osc*/drumsFusion"
  set :amp, drumsFusion[3]
  sample :drum_tom_hi_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :fusionRide do
  use_real_time
  drumsFusion = sync "/osc*/drumsFusion"
  set :amp, drumsFusion[4]
  sample :drum_cymbal_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :fusionHiHat do
  use_real_time
  drumsFusion = sync "/osc*/drumsFusion"
  set :amp, drumsFusion[5]
  sample :drum_cymbal_closed, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :fusionTomTom3 do
  use_real_time
  drumsFusion = sync "/osc*/drumsFusion"
  set :amp, drumsFusion[6]
  sample :drum_tom_lo_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end


/ =================================================================== /
/ ROCK DRUMS /

live_loop :rockBass do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[0]
  sample :drum_bass_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :rockSnare do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[1]
  sample :drum_snare_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :rockTomTom1 do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[2]
  sample :drum_tom_mid_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :rockTomTom2 do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[3]
  sample :drum_tom_hi_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :rockRide do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[4]
  sample :drum_cymbal_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :rockHiHat do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[5]
  sample :drum_cymbal_closed, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :rockTomTom3 do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[6]
  sample :drum_tom_lo_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :rockCrash do
  use_real_time
  drumsRock = sync "/osc*/drumsRock"
  set :amp, drumsRock[7]
  sample :drum_cymbal_open, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end


/ =================================================================== /
/ JAZZ DRUMS /

live_loop :jazzBass do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[0]
  sample :drum_bass_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzSnare do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[1]
  sample :drum_snare_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzTomTom1 do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[2]
  sample :drum_tom_mid_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzTomTom2 do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[3]
  sample :drum_tom_hi_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzRide do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[4]
  sample :drum_cymbal_hard, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end

live_loop :jazzHiHat do
  use_real_time
  drumsJazz = sync "/osc*/drumsJazz"
  set :amp, drumsJazz[5]
  sample :drum_cymbal_closed, amp: get(:amp), threshold: get(:gThreshold), attack: get(:gAttack), release: get(:gRelease)
end