uses sysutils;


type TArrString = array of string;
const EVowels = ['a', 'e', 'i', 'o', 'u'];
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
  i: integer;
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
  while i < Length(s) do
  begin
    case UpCase(s[i]) of
      'A': inc(vowels['a']);
      'E': inc(vowels['e']);
      'I': inc(vowels['i']);
      'O': inc(vowels['o']);
      'U': inc(vowels['u']);
    end;
    Inc(i);
  end;

  writeln('Vowels:');
  printCharCnt('a', vowels);
  printCharCnt('e', vowels);
  printCharCnt('i', vowels);
  printCharCnt('o', vowels);
  printCharCnt('u', vowels);

  writeln;
  writeln('Words <> last word:');

  arr := SplitString(s);
  arr := getNonLastWords(arr);

  i := 0;
  while (i < Length(arr)) do
  begin
    write(arr[i], ' ');
    Inc(i);
  end;
end;


{  Main  }
var
  s1, s2: string;
begin
  // s1 := 'a cd asd u uu iii i ii a';
  readln(s1);

  writeln('s1: ', s1);
  writeln;

  task1(s1);
end.
