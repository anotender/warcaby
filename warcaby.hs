import Data.List

data Fig = W | B | WD | BD | E deriving Show
type Board = [[Fig]]

charToFig :: Char -> Fig
charToFig 'w' = W
charToFig 'W' = WD
charToFig 'b' = B
charToFig 'B' = BD
charToFig '.' = E

figToChar :: Fig -> Char
figToChar W = 'w'
figToChar WD = 'W'
figToChar B = 'b'
figToChar BD = 'B'
figToChar E = '.'

fromStr :: String -> [Fig]
fromStr str = map charToFig str

toStr :: [Fig] -> String
toStr l = intersperse ' ' (map figToChar l)

initBoard :: String -> Board
initBoard str = map fromStr (lines str)

boardToStr :: Board -> [String]
boardToStr b = map toStr [x | x <- b]

addRowNumber num line = (show num) ++ " " ++ line
addRowNumbers board = zipWith addRowNumber [1..8] board

addColNumbers board = ["  1 2 3 4 5 6 7 8"] ++ board

showBoard :: Board -> String
showBoard board = unlines (addColNumbers (addRowNumbers (boardToStr board)))

getFig :: Board -> Int -> Int -> Fig
getFig board row col = board !! row !! col

replaceWithFig :: Fig -> [Fig] -> Int -> [Fig]
replaceWithFig fig (h:t) 0 = fig : t
replaceWithFig fig (h:t) col = h : replaceWithFig fig t (col - 1)

setFig :: Fig -> Board -> Int -> Int -> Board
setFig fig (h:t) 0 col = replaceWithFig fig h col : t
setFig fig (h:t) row col = h : setFig fig t (row - 1) col

b = initBoard ".b.b.b.b\nb.b.b.b.\n.b.b.b.b\n........\n........\nw.w.w.w.\n.w.w.w.w\nw.w.w.w."
x = showBoard b