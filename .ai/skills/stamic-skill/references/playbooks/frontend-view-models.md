# Frontend: View Models

**Summary:** View Models let you manipulate or add data in PHP right before a view is rendered. By setting `view_model` in entry data or anywhere in the cascade (e.g. collection inject), Statamic will run the ViewModel `data()` method and merge returned values into the view data.

**When to use:**
- You have complex template logic that’s awkward in Antlers.
- You want to compute per-view derived values (not stored back into entries).

## Steps
1. Add a view model via cascade injection (example: apply to an entire collection):
   ```yaml
   # content/collections/articles.yaml
   inject:
     view_model: App\\ViewModels\\ArticleStats
   ```
2. Create the view model class:
   ```php
   namespace App\ViewModels;

   use Statamic\View\ViewModel;

   class ArticleStats extends ViewModel
   {
     public function data(): array
     {
       $html = collect($this->cascade->get('content'))->implode('text', ' ');
       $content = strip_tags($html);
       $word_count = mb_str_word_count($content);

       return [
         'word_count' => $word_count,
         'read_time' => ceil($word_count / 200),
       ];
     }
   }
   ```
3. Use the injected variables in your template:
   ```antlers
   {{ word_count }} words / {{ read_time }}m
   ```
4. If you need global/portable computed values (usable anywhere, not just view render), consider Computed Values instead.

## Pitfalls / gotchas
- ViewModels modify **view data at render time**, not the underlying stored entry data.

## Sources
- https://statamic.dev/frontend/view-models
