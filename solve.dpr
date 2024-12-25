uses sysutils;

type TArrString = array of string;
type TCIArray = array[char] of integer;


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

  for i := 1 to Length(InputString) do
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
  end;
  
  if Length(CurrentWord) > 0 then
  begin
    Inc(WordCount);
    SetLength(Words, WordCount);
    Words[WordCount-1] := CurrentWord;
  end;
  
  SplitString := Words;
end;


procedure printCharCnt(c: char; cntMap: TCIArray);
begin
  if cntMap[c] <> 0 then
    writeln(c, ': ', cntMap[c]);
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
procedure task1(s: string);
var
  arr: TArrString;
  i, j: integer;
  isUnique: boolean;
  vowels: TCIArray; 
  c: char;
begin
  i := 0;
  vowels['a'] := 0;
  vowels['e'] := 0;
  vowels['i'] := 0;
  vowels['o'] := 0;
  vowels['u'] := 0;
 
  writeln;
  writeln('Words <> last word:');

  arr := SplitString(s);
  arr := getNonLastWords(arr);

  i := 0;
  while (i < Length(arr)) do
  begin
    j := 0;
    while j < Length(arr[i]) do
    begin
      case UpCase(arr[i][j + 1]) of
        'A': inc(vowels['a']);
        'E': inc(vowels['e']);
        'I': inc(vowels['i']);
        'O': inc(vowels['o']);
        'U': inc(vowels['u']);
      end;
      Inc(j);
    end;

    write(arr[i], ' ');
    Inc(i);
  end;

  writeln;
  writeln;
  writeln('Vowels:');
  printCharCnt('a', vowels);
  printCharCnt('e', vowels);
  printCharCnt('i', vowels);
  printCharCnt('o', vowels);
  printCharCnt('u', vowels);
end;



{   task2   }
function getBestSeq(start: string; words: TArrString; var len: integer): TArrString;
var
  i, maxL, newL: integer;
  candidate, rest, ans: TArrString;
  j: integer;
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

procedure task2(s: string);
var
  i, maxL, newL: integer;
  arr, candidate, rest, ans: TArrString;
  j: integer;
begin
  arr := SplitString(s);
  arr := getNonLastWords(arr);
  ans := arr;
  maxL := 0;

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
    write(ans[i], ' ');
    inc(i);
  end;
end;



{  Main  }
var
  s1, s2: string;
begin
  // s1 := 'a 1234567890 cd asd u uu iii i ii a';
  s1 := ' cd bc bc ab 1';
  // readln(s1);

  writeln('s1: ', s1);
  writeln;

  writeln('task1: ');
  task1(s1);

  writeln('-----------');
  writeln('task2: ');
  task2(s1);
end.

