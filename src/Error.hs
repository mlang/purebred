-- This file is part of purebred
-- Copyright (C) 2017  Fraser Tweedale
--
-- purebred is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

{-# LANGUAGE LambdaCase #-}

-- | Error types for purebred
--
module Error where

import Control.Lens (prism')
import qualified Data.ByteString as B

import Notmuch (AsNotmuchError(..), Status)

data Error
  = NotmuchError Status
  | InvalidTag B.ByteString
  | MessageNotFound B.ByteString -- message id
  | ThreadNotFound B.ByteString -- thread id
  | FileReadError FilePath IOError -- ^ failed to read a file
  | FileParseError FilePath String -- ^ failed to parse a file
  | InvalidQueryError String -- ^ unable to perform notmuch query
  | SendMailError String
  | ProcessError String
  | ParseError String
  deriving (Show, Eq)

instance AsNotmuchError Error where
  _NotmuchError = prism' NotmuchError (\case (NotmuchError e) -> Just e ; _ -> Nothing)
