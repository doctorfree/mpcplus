/***************************************************************************
 *   Copyright (C) 2008-2021 by Andrzej Rybczak                            *
 *   andrzej@rybczak.net                                                   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.              *
 ***************************************************************************/

#ifndef MPCPLUS_UTILITY_WIDE_STRING_H
#define MPCPLUS_UTILITY_WIDE_STRING_H

#include <string> // include before boost to compile on MACOSX
#include <boost/locale/encoding_utf.hpp>

template <typename StringT>
std::string ToString(StringT &&s)
{
	return boost::locale::conv::utf_to_utf<char>(std::forward<StringT>(s));
}
template <typename StringT>
std::wstring ToWString(StringT &&s)
{
	return boost::locale::conv::utf_to_utf<wchar_t>(std::forward<StringT>(s));
}

size_t wideLength(const std::wstring &ws);
void wideCut(std::wstring &ws, size_t max_length);

std::wstring wideShorten(const std::wstring &ws, size_t max_length);
inline std::string wideShorten(const std::string &s, size_t max_length)
{
	return ToString(wideShorten(ToWString(s), max_length));
}

#endif // MPCPLUS_UTILITY_WIDE_STRING_h
