#!/bin/bash

arch=
centos=
debian=
fedora=

[ -f /etc/os-release ] && . /etc/os-release
[ "${ID_LIKE}" == "debian" ] && debian=1
[ "${ID}" == "arch" ] || [ "${ID_LIKE}" == "arch" ] && arch=1
[ "${ID}" == "centos" ] && centos=1
[ "${ID}" == "fedora" ] && fedora=1
[ "${debian}" ] || [ -f /etc/debian_version ] && debian=1
[ "${arch}" ] || [ "${debian}" ] || [ "${fedora}" ] || [ "${centos}" ] || {
  echo "${ID_LIKE}" | grep debian > /dev/null && debian=1
}

cd src
rm -f mpcplus

if [ "${debian}" ]
then
  g++ -g -O2 -flto -ftree-vectorize -ffast-math -std=c++14 -o mpcplus curses/formatted_color.o curses/scrollpad.o curses/window.o screens/browser.o screens/clock.o screens/help.o screens/lastfm.o screens/lyrics.o screens/media_library.o screens/outputs.o screens/playlist.o screens/playlist_editor.o screens/screen.o screens/screen_type.o screens/search_engine.o screens/sel_items_adder.o screens/server_info.o screens/song_info.o screens/sort_playlist.o screens/tag_editor.o screens/tiny_tag_editor.o screens/visualizer.o utility/comparators.o utility/html.o utility/option_parser.o utility/sample_buffer.o utility/string.o utility/type_conversions.o utility/wide_string.o actions.o bindings.o charset.o configuration.o curl_handle.o display.o enums.o format.o global.o helpers.o lastfm_service.o lyrics_fetcher.o macro_utilities.o mpdpp.o mutable_song.o mpcplus.o settings.o song.o song_list.o status.o statusbar.o tags.o title.o -Wl,-Bstatic -lboost_date_time -lboost_filesystem -lboost_locale -lboost_program_options -lboost_regex -lboost_thread -lboost_system -licui18n -licuuc -licudata -lreadline -lncursesw -ltinfo -lfftw3 -Wl,-Bsymbolic-functions -Wl,-Bdynamic -lcurl -lmpdclient -ltag -lpthread -ldl -pthread
else
  if [ "${arch}" ]
  then
    g++ -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection -Wp,-D_GLIBCXX_ASSERTIONS -flto -ftree-vectorize -ffast-math -std=c++14 -Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z -Wl,relro -Wl,-z -Wl,now -Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z -Wl,relro -Wl,-z -Wl,now -o mpcplus curses/formatted_color.o curses/scrollpad.o curses/window.o screens/browser.o screens/clock.o screens/help.o screens/lastfm.o screens/lyrics.o screens/media_library.o screens/outputs.o screens/playlist.o screens/playlist_editor.o screens/screen.o screens/screen_type.o screens/search_engine.o screens/sel_items_adder.o screens/server_info.o screens/song_info.o screens/sort_playlist.o screens/tag_editor.o screens/tiny_tag_editor.o screens/visualizer.o utility/comparators.o utility/html.o utility/option_parser.o utility/sample_buffer.o utility/string.o utility/type_conversions.o utility/wide_string.o actions.o bindings.o charset.o configuration.o curl_handle.o display.o enums.o format.o global.o helpers.o lastfm_service.o lyrics_fetcher.o macro_utilities.o mpdpp.o mutable_song.o mpcplus.o settings.o song.o song_list.o status.o statusbar.o tags.o title.o  -Wl,-Bstatic -lboost_date_time -lboost_filesystem -lboost_locale -lboost_program_options -lboost_regex -lboost_thread -lboost_system -licui18n -licuuc -licudata -lreadline -lncursesw -lfftw3 -Wl,-Bsymbolic-functions -Wl,-Bdynamic -lcurl -lmpdclient -ltag -lz -lpthread -ldl -pthread
  else
    if [ "${centos}" ]
    then
      g++ -g -O2 -flto -ftree-vectorize -ffast-math -std=c++14 -o mpcplus curses/formatted_color.o curses/scrollpad.o curses/window.o screens/browser.o screens/clock.o screens/help.o screens/lastfm.o screens/lyrics.o screens/media_library.o screens/outputs.o screens/playlist.o screens/playlist_editor.o screens/screen.o screens/screen_type.o screens/search_engine.o screens/sel_items_adder.o screens/server_info.o screens/song_info.o screens/sort_playlist.o screens/tag_editor.o screens/tiny_tag_editor.o screens/visualizer.o utility/comparators.o utility/html.o utility/option_parser.o utility/sample_buffer.o utility/string.o utility/type_conversions.o utility/wide_string.o actions.o bindings.o charset.o configuration.o curl_handle.o display.o enums.o format.o global.o helpers.o lastfm_service.o lyrics_fetcher.o macro_utilities.o mpdpp.o mutable_song.o mpcplus.o settings.o song.o song_list.o status.o statusbar.o tags.o title.o  -Wl,-Bstatic -lboost_date_time -lboost_filesystem -lboost_locale -lboost_program_options -lboost_regex -lboost_thread -lboost_system -licui18n -licuuc -licudata -lreadline -lncursesw -ltinfo -lfftw3 -Wl,-Bsymbolic-functions -Wl,-Bdynamic -lcurl -lmpdclient -ltag -lpthread -ldl
    else
      if [ "${fedora}" ]
      then
        g++ -g -O2 -flto -ftree-vectorize -ffast-math -std=c++14 -o mpcplus curses/formatted_color.o curses/scrollpad.o curses/window.o screens/browser.o screens/clock.o screens/help.o screens/lastfm.o screens/lyrics.o screens/media_library.o screens/outputs.o screens/playlist.o screens/playlist_editor.o screens/screen.o screens/screen_type.o screens/search_engine.o screens/sel_items_adder.o screens/server_info.o screens/song_info.o screens/sort_playlist.o screens/tag_editor.o screens/tiny_tag_editor.o screens/visualizer.o utility/comparators.o utility/html.o utility/option_parser.o utility/sample_buffer.o utility/string.o utility/type_conversions.o utility/wide_string.o actions.o bindings.o charset.o configuration.o curl_handle.o display.o enums.o format.o global.o helpers.o lastfm_service.o lyrics_fetcher.o macro_utilities.o mpdpp.o mutable_song.o mpcplus.o settings.o song.o song_list.o status.o statusbar.o tags.o title.o  -Wl,-Bstatic -lboost_date_time -lboost_filesystem -lboost_locale -lboost_program_options -lboost_regex -lboost_thread -lboost_system -licui18n -licuuc -licudata -lreadline -lncursesw -ltinfo -lfftw3 -Wl,-Bsymbolic-functions -Wl,-Bdynamic -lcurl -lmpdclient -ltag -lpthread -ldl
      else
        g++ -g -O2 -flto -ftree-vectorize -ffast-math -std=c++14 -o mpcplus curses/formatted_color.o curses/scrollpad.o curses/window.o screens/browser.o screens/clock.o screens/help.o screens/lastfm.o screens/lyrics.o screens/media_library.o screens/outputs.o screens/playlist.o screens/playlist_editor.o screens/screen.o screens/screen_type.o screens/search_engine.o screens/sel_items_adder.o screens/server_info.o screens/song_info.o screens/sort_playlist.o screens/tag_editor.o screens/tiny_tag_editor.o screens/visualizer.o utility/comparators.o utility/html.o utility/option_parser.o utility/sample_buffer.o utility/string.o utility/type_conversions.o utility/wide_string.o actions.o bindings.o charset.o configuration.o curl_handle.o display.o enums.o format.o global.o helpers.o lastfm_service.o lyrics_fetcher.o macro_utilities.o mpdpp.o mutable_song.o mpcplus.o settings.o song.o song_list.o status.o statusbar.o tags.o title.o -Wl,-Bstatic -lboost_date_time -lboost_filesystem -lboost_locale -lboost_program_options -lboost_regex -lboost_thread -lboost_system -licui18n -licuuc -licudata -lreadline -lncursesw -ltinfo -lfftw3 -Wl,-Bsymbolic-functions -Wl,-Bdynamic -lcurl -lmpdclient -ltag -lpthread -ldl -pthread
      fi
    fi
  fi
fi

