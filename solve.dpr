uses sysutils;

type TArrString = array of string;
type TCIArray = array[char] of integer;


{ shared }
function SplitString(const InputString: string): TArrString;
var
  words: TArrString;
  CurrentWord: string;
  i: Integer;
  WordCount: Integer;
begin
  SetLength(Words, 0);
  CurrentWord := '';
  WordCount := 0;

  i := 1;
  while i <= Length(InputString) do
  begin
    if InputString[i] <> ' ' then
    begin
      CurrentWord := CurrentWord + InputString[i];
    end
    else if Length(CurrentWord) > 0 then
    begin
      Inc(WordCount);
      SetLength(Words, WordCount);
      Words[WordCount-1] := CurrentWord;
      CurrentWord := '';
    end;
    inc(i);
  end;
  
  if Length(CurrentWord) > 0 then
  begin
    Inc(WordCount);
    SetLength(Words, WordCount);
    Words[WordCount-1] := CurrentWord;
  end;
  
  SplitString := Words;
end;

function getNonLastWords(words: TArrString): TArrString;
var
  i: integer;
  arr: TArrString;
begin
  i := 0;
  SetLength(arr, 0);
  while i < Length(words) - 1 do
  begin
    if words[i] <> words[Length(words)-1] then 
    begin
      SetLength(arr, Length(arr)+1);
      arr[Length(arr)-1] := words[i];
    end;

    Inc(i);
  end;

  getNonLastWords := arr;
end;





{   task1   }
procedure printCharCnt(c: char; cntMap: TCIArray);
begin
  if cntMap[c] <> 0 then
    writeln('''', c, ''': ', cntMap[c]);
end;

function task1(s: string): string;
var
  arr: TArrString;
  i, j: integer;
  vowels: TCIArray; 
  s1: string;
begin
  s1 := '';
  i := 0;
  vowels['a'] := 0;
  vowels['e'] := 0;
  vowels['i'] := 0;
  vowels['o'] := 0;
  vowels['u'] := 0;
 
  arr := SplitString(s);
  arr := getNonLastWords(arr);

  i := 0;
  while (i < Length(arr)) do
  begin
    j := 0;
    while j < Length(arr[i]) do
    begin
      inc(vowels[LowerCase(arr[i][j + 1])]);
      Inc(j);
    end;

    Insert(arr[i] + ' ', s1, length(s1)+1);
    Inc(i);
  end;

  printCharCnt('a', vowels);
  printCharCnt('e', vowels);
  printCharCnt('i', vowels);
  printCharCnt('o', vowels);
  printCharCnt('u', vowels);
  task1 := s1;
end;



{   task2   }
function getBestSeq(start: string; words: TArrString; var len: integer): TArrString;
var
  i, maxL, newL: integer;
  candidate, rest, ans: TArrString;
begin
  ans := words;
  Insert(start, ans, 0);
  maxL := len;
  i := 0;

  while (i < Length(words)) do
  begin
    if (start[Length(start)] = words[i][1]) then
    begin
      rest := words;
      delete(rest, i, 1);

      newL := len + 1;
      candidate := getBestSeq(words[i], rest, newl);

      if (newL > maxL) then
      begin
        ans := candidate;
        insert(start, ans, 0);
        maxL := newL;
      end;
    end;
    inc(i);
  end;

  len := maxL;
  getBestSeq := ans;
end;

function task2(s: string): string;
var
  i, maxL, newL: integer;
  arr, candidate, rest, ans: TArrString;
  s2: string;
begin
  arr := SplitString(s);
  ans := arr;
  maxL := 0;
  s2 := '';

  i := 0;
  while (i < Length(arr)) do
  begin
    rest := arr;
    delete(rest, i, 1);

    newL := 0;
    candidate := getBestSeq(arr[i], rest, newL);

    if (newL > maxL) then
    begin
      ans := candidate;
      maxL := newL;
    end;
    inc(i);
  end;

  i := 0;
  while (i < Length(ans)) do
  begin
    Insert(ans[i] + ' ', s2, length(s2) + 1);
    inc(i);
  end;
  
  task2 := s2;
end;



{  Main  }
var
  s, s1, s2: string;
begin
  // s := 'a 1234567890 cd asd u uu iii i ii a';
  s := 'a 1234567890 cd asd u uu iiia i ii a';
  // s := ' cd bc bc ab 1';
  // s := 'ab bc cd cd cd cd cd ab bc da a'
  // readln(s);

  writeln('s: ', s);

  writeln;
  writeln('-----------');
  writeln('#  task1  #');
  writeln('-----------');
  s1 := task1(s);
  if (s1 = '') then
    writeln('<Пустая строка>')
  else
    writeln('s1: ', s1);

  writeln;
  writeln('-----------');
  writeln('#  task2  #');
  writeln('-----------');
  s2 := task2(s1);
  if (s2 = '') then
    writeln('<Пустая строка>')
  else
    writeln('s2: ', s2);
end.

