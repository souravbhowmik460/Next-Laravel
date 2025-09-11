<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreCardRequest;
use App\Http\Requests\UpdateCardRequest;
use App\Models\Card;
use App\Services\CardService;
use Illuminate\Http\Request;

class CardController extends Controller
{
    protected $cardService;

    public function __construct(CardService $cardService)
    {
        $this->cardService = $cardService;
        
    }

    public function index($userId)
    {
        $user = auth()->user();
        if (!$user || (int)$user->id !== (int)$userId) {
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
        }

        $cards = $this->cardService->getCardsByUser($userId);
        return response()->json(['success' => true, 'data' => $cards]);
    }

    public function store(StoreCardRequest $request)
    {
        $user = auth()->user();
        $card = $this->cardService->createCard($user, $request->validated());
        return response()->json(['success' => true, 'data' => $card], 201);
    }

    public function update(UpdateCardRequest $request, $cardId)
    {
        $user = auth()->user();
        $card = $this->cardService->updateCard($user, $cardId, $request->validated());
        return response()->json(['success' => true, 'data' => $card]);
    }

    public function destroy(Card $card)
    {
        $user = auth()->user();
        $this->cardService->deleteCard($user, $card);
        return response()->json(['success' => true]);
    }
}
