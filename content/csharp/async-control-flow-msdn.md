---
title: "Async Control Flow Msdn"
date: 2018-12-21T22:02:13+09:00
Categories: ["csharp"]
Tags: ["C#", "Programming", "async", "await"]
Author: "nolleh"
---

# 개요  
---
> 다음에서 발췌  
> [비동기 프로그램의 제어 흐름](https://docs.microsoft.com/ko-kr/dotnet/csharp/programming-guide/concepts/async/control-flow-in-async-programs)


# 코드
```csharp  
public partial class MainWindow : Window
{
    // . . .
    private async void startButton_Click(object sender, RoutedEventArgs e)
    {
        // ONE
        Task<int> getLengthTask = AccessTheWebAsync();

        // FOUR
        int contentLength = await getLengthTask;

        // SIX
        resultsTextBox.Text +=
            $"\r\nLength of the downloaded string: {contentLength}.\r\n";
    }

    async Task<int> AccessTheWebAsync()
    {
        // TWO
        HttpClient client = new HttpClient();
        Task<string> getStringTask =
            client.GetStringAsync("https://msdn.microsoft.com");

        // THREE
        string urlContents = await getStringTask;

        // FIVE
        return urlContents.Length;
    }
}
```

Three 에서 yield 되어 Four.


