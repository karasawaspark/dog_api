# dogアプリ
![Simulator Screen Recording - iPhone 14 Pro - 2024-03-08 at 13 16 40](https://github.com/karasawaspark/dog_api/assets/156158259/490db18c-a282-44b6-bc0f-2b870fd80baa)


<br>【概要】
<br>犬種画面：TableViewにAPIから読み込んだ犬種を表示する
<br>画像表示：画面１で選択したデータを引き継ぎ、選択された犬種の画像データをAlamofireを使ってCollectionViewに表示する
<br>画像詳細：画面２で選択した画像データをImageViewに表示する

<br>【ポイント】
<br>・外部APIおよびJSONデータの利用
<br>・Alamofireによる画像の最適化

<br>【工夫したところ】
<br>・JSONデータの読み込みを別クラスで行うことで、コードの可読性を上げた。
