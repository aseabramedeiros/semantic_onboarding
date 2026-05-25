% ===== KOA Combined Output | contract_id: contrato_ocs_179_2021 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_179_2021_-_ZIVA_(Solução_unificada_LAN_e_WLAN).pl
% contract_id: contrato_ocs_179_2021

instance_of(contrato_ocs_179_2021, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(ziva_tecnologia_e_solucoes_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_179_2021).
plays_role(ziva_tecnologia_e_solucoes_ltda, hired_service_provider_role, contrato_ocs_179_2021).

clause_of(clausula_primeira_objeto, contrato_ocs_179_2021).
clause_of(clausula_segunda_vigencia, contrato_ocs_179_2021).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_179_2021).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_179_2021).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_179_2021).
clause_of(clausula_sexta_preco, contrato_ocs_179_2021).
clause_of(clausula_setima_pagamento, contrato_ocs_179_2021).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_179_2021).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_179_2021).
clause_of(clausula_decima_primeira_obrigações_contratada, contrato_ocs_179_2021).
clause_of(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, contrato_ocs_179_2021).
clause_of(clausula_decima_terceira_sigilo_das_informacoes, contrato_ocs_179_2021).
clause_of(clausula_decima_quarta_obrigações_do_bndes, contrato_ocs_179_2021).
clause_of(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, contrato_ocs_179_2021).
clause_of(clausula_decima_sexta_penalidades, contrato_ocs_179_2021).
clause_of(clausula_decima_setima_alterações_contratuais, contrato_ocs_179_2021).
clause_of(clausula_decima_oitava_extinção_do_contrato, contrato_ocs_179_2021).
clause_of(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, contrato_ocs_179_2021).
clause_of(clausula_vigesima_disposições_finais, contrato_ocs_179_2021).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_179_2021).
clause_of(clausula_vigesima_primeira_foro, contrato_ocs_179_2021).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, ziva_tecnologia_e_solucoes_ltda, provide_unified_network_solution).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_unified_network_solution).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, ziva_tecnologia_e_solucoes_ltda, execute_supply_and_implementation).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, ziva_tecnologia_e_solucoes_ltda, provide_continued_services).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_supply_and_implementation).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_continued_services).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, ziva_tecnologia_e_solucoes_ltda, execute_service_according_to_proposal_and_reference).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_execution_according_to_proposal_and_reference).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, ziva_tecnologia_e_solucoes_ltda, execute_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, ziva_tecnologia_e_solucoes_ltda, price_reduction_due_to_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, impose_price_reduction_due_to_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, ziva_tecnologia_e_solucoes_ltda, suffer_penalties_for_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, impose_penalties_for_non_compliance).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, ziva_tecnologia_e_solucoes_ltda, receive_indemnization).
legal_relation_instance(clausula_sexta_preco, duty_to_act, ziva_tecnologia_e_solucoes_ltda, bear_dimensioning_burdens).
legal_relation_instance(clausula_sexta_preco, subjection, ziva_tecnologia_e_solucoes_ltda, values_proportionally_reduced).
legal_relation_instance(clausula_sexta_preco, duty_to_act, ziva_tecnologia_e_solucoes_ltda, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contract_object).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, ziva_tecnologia_e_solucoes_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, ziva_tecnologia_e_solucoes_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, ziva_tecnologia_e_solucoes_ltda, send_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_amounts).
legal_relation_instance(clausula_setima_pagamento, subjection, ziva_tecnologia_e_solucoes_ltda, payments_subject_to_tax_withholding).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, ziva_tecnologia_e_solucoes_ltda, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, disability, ziva_tecnologia_e_solucoes_ltda, claim_retroactive_price_adjustment_or_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, ziva_tecnologia_e_solucoes_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, ziva_tecnologia_e_solucoes_ltda, request_price_revisions_or_readjustments).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, ziva_tecnologia_e_solucoes_ltda, provide_supporting_documentation).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_request_analysis).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, ziva_tecnologia_e_solucoes_ltda, present_information_for_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment_revision_request).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, ziva_tecnologia_e_solucoes_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, ziva_tecnologia_e_solucoes_ltda, complement_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, ziva_tecnologia_e_solucoes_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, ziva_tecnologia_e_solucoes_ltda, obtain_new_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, maintain_qualification).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, communicate_penalty).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, repair_contract_object).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, pay_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, provide_exclusion_proof).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, obey_bndes_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, appoint_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratada, duty_to_act, ziva_tecnologia_e_solucoes_ltda, allow_central_bank_access).
legal_relation_instance(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, maintain_integrity).
legal_relation_instance(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity).
legal_relation_instance(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, prevent_employee_favortism).
legal_relation_instance(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, not_allocate_family_members).
legal_relation_instance(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, observe_code_of_ethics).
legal_relation_instance(clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, adopt_good_sustainability_practices).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, cumprir_regras_de_sigilo).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, cumprir_diretrizes_de_seguranca).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, nao_acessar_informacoes_sigilosas).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, manter_sigilo_das_informacoes).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, informar_violacao_de_sigilo).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, entregar_materiais_ao_bndes).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, nao_utilizar_informacao_sigilosa).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, apresentar_termos_de_confidencialidade).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, observar_termo_de_confidencialidade).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, ziva_tecnologia_e_solucoes_ltda, assegurar_adesao_da_equipe).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contratada).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty_application).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, right_to_action, ziva_tecnologia_e_solucoes_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, modify_contract_manager).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_code_of_ethics).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, right_to_action, ziva_tecnologia_e_solucoes_ltda, receive_necessary_information).
legal_relation_instance(clausula_decima_quarta_obrigações_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_procedures).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, omit_contract_cession).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, omit_credit_cession).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, omit_issuing_credit_titles).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, omit_contractual_succession).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, subjection, ziva_tecnologia_e_solucoes_ltda, obtain_bndes_agreement).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, duty_to_act, ziva_tecnologia_e_solucoes_ltda, maintain_contract_conditions).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, permission_to_act, ziva_tecnologia_e_solucoes_ltda, subcontract_object).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, subjection, ziva_tecnologia_e_solucoes_ltda, obtain_bndes_agreement_subcontract).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, duty_to_act, ziva_tecnologia_e_solucoes_ltda, be_responsible_to_bndes).
legal_relation_instance(clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, subjection, ziva_tecnologia_e_solucoes_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, subjection, ziva_tecnologia_e_solucoes_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, ziva_tecnologia_e_solucoes_ltda, defend_against_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_sexta_penalidades, duty_to_act, ziva_tecnologia_e_solucoes_ltda, observe_laws).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_formalizing_contract_alteration).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_due_to_refusal).
legal_relation_instance(clausula_decima_setima_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_alteration_via_epistolary).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notification).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_to_defend).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_breaching_party).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_contractor_bankruptcy).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_loss_qualification).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_unlawful_act).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_compliance).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_suspension).
legal_relation_instance(clausula_decima_oitava_extinção_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_cessao_descumprimento).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, adopt_data_security_measures).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, obtain_consent_data_owners).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_omit, ziva_tecnologia_e_solucoes_ltda, omit_share_data_without_consent).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, inform_bndes_data_requests).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, maintain_data_operation_records).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, communicate_data_breaches).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, eliminate_data_after_contract).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, provide_data_access_to_owner).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, ensure_data_security).
legal_relation_instance(clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, duty_to_act, ziva_tecnologia_e_solucoes_ltda, follow_bndes_instructions_data_requests).
legal_relation_instance(clausula_vigesima_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigesima_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_waiver_due_to_tolerance).
legal_relation_instance(clausula_nona_matriz_riscos, subjection, ziva_tecnologia_e_solucoes_ltda, be_responsible_for_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, ziva_tecnologia_e_solucoes_ltda, respect_economic_financial_equilibrium_clause).
legal_relation_instance(clausula_vigesima_primeira_foro, power, unknown, choose_rio_de_janeiro_forum).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_inspection).
action_label(accept_inspection, 'Accept inspection').
action_type(adopt_data_security_measures).
action_label(adopt_data_security_measures, 'Adopt data security measures').
action_type(adopt_good_sustainability_practices).
action_label(adopt_good_sustainability_practices, 'Adopt good sustainability practices').
action_type(adopt_security_measures).
action_label(adopt_security_measures, 'Adopt security measures').
action_type(allow_central_bank_access).
action_label(allow_central_bank_access, 'Allow central bank access').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract).
action_label(alter_contract, 'Alter contract').
action_type(analyze_price_adjustment_revision_request).
action_label(analyze_price_adjustment_revision_request, 'Analyze adjustment/revision request').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_penalty).
action_label(apply_penalty, 'Apply penalty').
action_type(appoint_representative).
action_label(appoint_representative, 'Appoint representative').
action_type(apresentar_termos_de_confidencialidade).
action_label(apresentar_termos_de_confidencialidade, 'Present confidentiality terms').
action_type(assegurar_adesao_da_equipe).
action_label(assegurar_adesao_da_equipe, 'Ensure team adherence').
action_type(assume_integral_position).
action_label(assume_integral_position, 'Assume integral position').
action_type(assume_technical_responsibility).
action_label(assume_technical_responsibility, 'Assume technical responsibility').
action_type(be_responsible_for_allocated_risks).
action_label(be_responsible_for_allocated_risks, 'Be responsible for allocated risks').
action_type(be_responsible_to_bndes).
action_label(be_responsible_to_bndes, 'Be responsible to BNDES').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(bear_dimensioning_burdens).
action_label(bear_dimensioning_burdens, 'Bear dimensioning burdens').
action_type(choose_rio_de_janeiro_forum).
action_label(choose_rio_de_janeiro_forum, 'Choose Rio de Janeiro forum').
action_type(claim_retroactive_price_adjustment_or_revision).
action_label(claim_retroactive_price_adjustment_or_revision, 'Claim retroactive price adjustment/revision').
action_type(claim_waiver_due_to_tolerance).
action_label(claim_waiver_due_to_tolerance, 'Claim waiver due to tolerance').
action_type(collaborate_investigation_audits).
action_label(collaborate_investigation_audits, 'Collaborate with data audits').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate admin procedure').
action_type(communicate_data_breaches).
action_label(communicate_data_breaches, 'Communicate data breaches').
action_type(communicate_instructions_procedures).
action_label(communicate_instructions_procedures, 'Communicate instructions').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(communicate_penalty_application).
action_label(communicate_penalty_application, 'Communicate penalty').
action_type(compensate_damages).
action_label(compensate_damages, 'Compensate damages').
action_type(compensate_damages_due_to_refusal).
action_label(compensate_damages_due_to_refusal, 'Subject to compensate damages for refusal').
action_type(complement_guarantee).
action_label(complement_guarantee, 'Complement guarantee').
action_type(comply_security_rules).
action_label(comply_security_rules, 'Comply security rules').
action_type(corporate_operation_succession).
action_label(corporate_operation_succession, 'Perform corporate operation succession').
action_type(cumprir_diretrizes_de_seguranca).
action_label(cumprir_diretrizes_de_seguranca, 'Comply with security guidelines').
action_type(cumprir_regras_de_sigilo).
action_label(cumprir_regras_de_sigilo, 'Comply with confidentiality rules').
action_type(deduct_amounts).
action_label(deduct_amounts, 'Deduct amounts').
action_type(defend_against_penalties).
action_label(defend_against_penalties, 'Right to defend against penalties').
action_type(demand_compliance).
action_label(demand_compliance, 'Demand compliance').
action_type(demand_contract_object).
action_label(demand_contract_object, 'Demand contract object').
action_type(demand_service_according_to_standards).
action_label(demand_service_according_to_standards, 'Demand service per standards').
action_type(demand_service_execution_according_to_proposal_and_reference).
action_label(demand_service_execution_according_to_proposal_and_reference, 'Demand service as specified').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effect_payment).
action_label(effect_payment, 'Effect payment').
action_type(eliminate_data_after_contract).
action_label(eliminate_data_after_contract, 'Eliminate data after contract').
action_type(ensure_data_privacy).
action_label(ensure_data_privacy, 'Ensure data privacy').
action_type(ensure_data_security).
action_label(ensure_data_security, 'Ensure data security').
action_type(entregar_materiais_ao_bndes).
action_label(entregar_materiais_ao_bndes, 'Return materials to BNDES').
action_type(execute_contract).
action_label(execute_contract, 'Execute contract').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_service_according_to_proposal_and_reference).
action_label(execute_service_according_to_proposal_and_reference, 'Execute service as specified').
action_type(execute_service_according_to_standards).
action_label(execute_service_according_to_standards, 'Execute service per standards').
action_type(execute_supply_and_implementation).
action_label(execute_supply_and_implementation, 'execute supply and implementation').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights under contract').
action_type(follow_bndes_instructions_data_requests).
action_label(follow_bndes_instructions_data_requests, 'Follow BNDES instructions on data requests').
action_type(formalize_alteration_via_epistolary).
action_label(formalize_alteration_via_epistolary, 'Formalize alteration via epistolary').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract change').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(impose_penalties_for_non_compliance).
action_label(impose_penalties_for_non_compliance, 'Impose penalties').
action_type(impose_price_reduction_due_to_non_compliance).
action_label(impose_price_reduction_due_to_non_compliance, 'Impose price reduction').
action_type(indicate_contact_data).
action_label(indicate_contact_data, 'Indicate contact data').
action_type(inform_bndes_data_requests).
action_label(inform_bndes_data_requests, 'Inform BNDES of data requests').
action_type(inform_preposto_data).
action_label(inform_preposto_data, 'Inform preposto data').
action_type(informar_violacao_de_sigilo).
action_label(informar_violacao_de_sigilo, 'Report confidentiality breach').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(limitar_acesso_a_informacoes).
action_label(limitar_acesso_a_informacoes, 'Limit information access').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Maintain contract conditions').
action_type(maintain_data_operation_records).
action_label(maintain_data_operation_records, 'Maintain data operation records').
action_type(maintain_escalation_list).
action_label(maintain_escalation_list, 'Maintain escalation list').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain integrity').
action_type(maintain_qualification).
action_label(maintain_qualification, 'Maintain qualification').
action_type(make_payments_to_contratada).
action_label(make_payments_to_contratada, 'Make payments').
action_type(manter_sigilo_das_informacoes).
action_label(manter_sigilo_das_informacoes, 'Maintain confidentiality').
action_type(modify_contract_manager).
action_label(modify_contract_manager, 'Modify contract manager').
action_type(nao_acessar_informacoes_sigilosas).
action_label(nao_acessar_informacoes_sigilosas, 'Do not access confidential info').
action_type(nao_utilizar_informacao_sigilosa).
action_label(nao_utilizar_informacao_sigilosa, 'Do not use confidential info').
action_type(negotiate_price_reduction).
action_label(negotiate_price_reduction, 'Negotiate price reduction').
action_type(not_allocate_family_members).
action_label(not_allocate_family_members, 'Not allocate family members').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_reverse_engineer).
action_label(not_reverse_engineer, 'Not reverse engineer').
action_type(notify_breaching_party).
action_label(notify_breaching_party, 'Notify breaching party').
action_type(notify_risks).
action_label(notify_risks, 'Notify risks').
action_type(obey_bndes_instructions).
action_label(obey_bndes_instructions, 'Obey BNDES instructions').
action_type(observar_termo_de_confidencialidade).
action_label(observar_termo_de_confidencialidade, 'Observe confidentiality term').
action_type(observe_code_of_ethics).
action_label(observe_code_of_ethics, 'Observe code of ethics').
action_type(observe_laws).
action_label(observe_laws, 'Observe laws').
action_type(obtain_bndes_agreement).
action_label(obtain_bndes_agreement, 'Obtain BNDES agreement').
action_type(obtain_bndes_agreement_subcontract).
action_label(obtain_bndes_agreement_subcontract, 'Obtain BNDES agreement for subcontract').
action_type(obtain_consent_data_owners).
action_label(obtain_consent_data_owners, 'Obtain data owner consent').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract assignment').
action_type(omit_contractual_succession).
action_label(omit_contractual_succession, 'Omit contractual succession').
action_type(omit_credit_cession).
action_label(omit_credit_cession, 'Omit credit assignment').
action_type(omit_formalizing_contract_alteration).
action_label(omit_formalizing_contract_alteration, 'Omit formalizing contract change').
action_type(omit_issuing_credit_titles).
action_label(omit_issuing_credit_titles, 'Omit issuing credit titles').
action_type(omit_share_data_without_consent).
action_label(omit_share_data_without_consent, 'Don\'t share data without consent').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(payments_subject_to_tax_withholding).
action_label(payments_subject_to_tax_withholding, 'Subject to tax withholding').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_confidentiality_terms_professionals).
action_label(present_confidentiality_terms_professionals, 'Present confidentiality terms (professionals)').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_information_for_price_reduction).
action_label(present_information_for_price_reduction, 'Present info for price reduction').
action_type(prevent_employee_favortism).
action_label(prevent_employee_favortism, 'Prevent employee favortism').
action_type(price_reduction_due_to_non_compliance).
action_label(price_reduction_due_to_non_compliance, 'Subject to price reduction').
action_type(provide_clarifications).
action_label(provide_clarifications, 'Provide clarifications').
action_type(provide_code_of_ethics).
action_label(provide_code_of_ethics, 'Provide code of ethics').
action_type(provide_continued_services).
action_label(provide_continued_services, 'provide continued services').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_access_to_owner).
action_label(provide_data_access_to_owner, 'Provide data access to owner').
action_type(provide_data_operation_records).
action_label(provide_data_operation_records, 'Provide data operation records').
action_type(provide_exclusion_proof).
action_label(provide_exclusion_proof, 'Provide exclusion proof').
action_type(provide_information_for_service).
action_label(provide_information_for_service, 'Provide information for service').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_opportunity_to_defend).
action_label(provide_opportunity_to_defend, 'Provide opportunity to defend').
action_type(provide_supporting_documentation).
action_label(provide_supporting_documentation, 'Provide supporting documentation').
action_type(provide_unified_network_solution).
action_label(provide_unified_network_solution, 'Provide unified network solution').
action_type(provide_written_notification).
action_label(provide_written_notification, 'Provide written notification').
action_type(receive_continued_services).
action_label(receive_continued_services, 'right to receive continued services').
action_type(receive_credits).
action_label(receive_credits, 'Receive credits').
action_type(receive_indemnization).
action_label(receive_indemnization, 'No right to receive indemnization').
action_type(receive_necessary_information).
action_label(receive_necessary_information, 'Receive necessary information').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(receive_supply_and_implementation).
action_label(receive_supply_and_implementation, 'right to receive supply and implementation').
action_type(receive_unified_network_solution).
action_label(receive_unified_network_solution, 'Receive unified network solution').
action_type(repair_contract_object).
action_label(repair_contract_object, 'Repair contract object').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_price_revisions_or_readjustments).
action_label(request_price_revisions_or_readjustments, 'Request price revisions/readjustments').
action_type(request_proof_of_qualification).
action_label(request_proof_of_qualification, 'Request proof of qualification').
action_type(respect_economic_financial_equilibrium_clause).
action_label(respect_economic_financial_equilibrium_clause, 'Respect economic-financial equilibrium clause').
action_type(respond_damages).
action_label(respond_damages, 'Respond damages').
action_type(return_bndes_resources).
action_label(return_bndes_resources, 'Return BNDES resources').
action_type(return_documents).
action_label(return_documents, 'Return documents').
action_type(send_fiscal_document).
action_label(send_fiscal_document, 'Send fiscal document').
action_type(subcontract_object).
action_label(subcontract_object, 'Subcontract object').
action_type(subject_to_damages_data_misuse).
action_label(subject_to_damages_data_misuse, 'Subject to damages for data misuse').
action_type(suffer_penalties_for_non_compliance).
action_label(suffer_penalties_for_non_compliance, 'Subject to penalties').
action_type(suspend_request_analysis).
action_label(suspend_request_analysis, 'Suspend request analysis').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_cessao_descumprimento).
action_label(terminate_contract_cessao_descumprimento, 'Terminate due to Clause VI').
action_type(terminate_contract_contractor_bankruptcy).
action_label(terminate_contract_contractor_bankruptcy, 'Terminate due to bankruptcy').
action_type(terminate_contract_extincao).
action_label(terminate_contract_extincao, 'Terminate due to extinction').
action_type(terminate_contract_force_majeure).
action_label(terminate_contract_force_majeure, 'Terminate due to force majeure').
action_type(terminate_contract_loss_qualification).
action_label(terminate_contract_loss_qualification, 'Terminate due to loss of qualification').
action_type(terminate_contract_suspension).
action_label(terminate_contract_suspension, 'Terminate due to suspension').
action_type(terminate_contract_unlawful_act).
action_label(terminate_contract_unlawful_act, 'Terminate due to unlawful act').
action_type(values_proportionally_reduced).
action_label(values_proportionally_reduced, 'Subject to proportionally reduced values').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_179_2021).
contract_metadata(contrato_ocs_179_2021, numero_ocs, '179/2021').
contract_metadata(contrato_ocs_179_2021, numero_sap, '4400004714').
contract_metadata(contrato_ocs_179_2021, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_179_2021, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'ZIVA TECNOLOGIA E SOLUÇÕES LTDA.']).
contract_metadata(contrato_ocs_179_2021, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_179_2021, contratado, 'ZIVA TECNOLOGIA E SOLUÇÕES LTDA.').
contract_metadata(contrato_ocs_179_2021, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_179_2021, cnpj_contratado, '05.816.526/0001-68').
contract_metadata(contrato_ocs_179_2021, procedimento_licitatorio, 'Pregão Eletrônico nº 25/2021 - BNDES').
contract_metadata(contrato_ocs_179_2021, data_autorizacao, '01/04/2021').
contract_metadata_raw(contrato_ocs_179_2021, 'IP ATI//DESET', '07/2021', 'preamble').
contract_metadata(contrato_ocs_179_2021, data_ip_ati_degat, '24/03/2021').
contract_metadata(contrato_ocs_179_2021, rubrica_orcamentaria, '175010051').
contract_metadata(contrato_ocs_179_2021, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_179_2021, rubrica_orcamentaria, '3101700040').
contract_metadata(contrato_ocs_179_2021, centro_custo, 'BN30005000').
contract_metadata(contrato_ocs_179_2021, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_179_2021, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_179_2021, regulamento, 'Regulamento de Formalização, Execução e Fiscalização dos Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_179_2021, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a aquisição de solução unificada de rede sem fio (WLAN - Wireless Local Area Network) e rede cabeada (LAN - Local Area Network), incluindo sua infraestrutura e acessórios, bem como plataforma de gerenciamento da solução para monitoração, configuração e administração dos ativos, em conjunto com os serviços de treinamento, instalação e suporte técnico, conforme especificações constantes do Termo de Referência e da Proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_179_2021, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá a vigência de: I -  até 10 (dez) meses, contados da assinatura do contrato, para execução do fornecimento e implantação da solução, incluindo todas as fases até a emissão do Termo de Recebimento Definitivo; e II - 60 (sessenta) meses, contados a partir da emissão do Termo de Recebimento Definitivo, para prestação dos serviços continuados (assistência técnica/suporte) e sob demanda (treinamento).').
contract_clause(contrato_ocs_179_2021, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do serviço respeitará as especificações constantes da Proposta apresentada pela CONTRATADA e do respectivo Termo de Referência, respectivamente, Anexos II e I deste Contrato.').
contract_clause(contrato_ocs_179_2021, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'O serviço contratado deverá ser executado de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, segundo as metas de nível de serviço descritas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Único O descumprimento de qualquer meta de nível de serviço pactuada acarretará a aplicação de índice de redução do preço previsto no Termo de Referência sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_179_2021, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no respectivo Termo de Referência (Anexo I deste Contrato).').
contract_clause(contrato_ocs_179_2021, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de até R$ 10.972.443,73 (dez milhões e novecentos e setenta e dois mil e quatrocentos e quarenta e três reais e setenta e três centavos), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.    Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização à CONTRATADA.  Parágrafo Quarto A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_179_2021, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, a cada entrega, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte, mediante prévia autorização do BNDES.  Parágrafo Segundo Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Terceiro Para toda efetivação de pagamento, a CONTRATADA deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal ao sistema de captação de notas fiscais eletrônicas do BNDES, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro - EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP nº 20.031-917, no período compreendido entre 10h e 18h.  Parágrafo Quarto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato  V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador dos serviços: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador dos serviços: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso; e  XIII. código dos serviços, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento.  Parágrafo Quinto O documento fiscal ou equivalente legal emitido pela CONTRATADA deverá estar em conformidade com a legislação do Município onde a CONTRATADA esteja estabelecido, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento.  Parágrafo Sexto Caso a CONTRATADA emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pela CONTRATADA, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Sétimo Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado; e V. comprovante de que a CONTRATADA recolheu para o Regime Geral de Previdência Social, no mês respectivo, sobre o limite máximo do salário-de-contribuição ou em valor inferior, se for o caso.  Parágrafo Oitavo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Nono Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Décimo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA.  Parágrafo Décimo Primeiro Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_179_2021, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.   Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 26/05/2021, data da sessão inaugural, e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação - ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.     Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e III. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, e este for prorrogado, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_179_2021, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.  Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_179_2021, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'A CONTRATADA prestará garantia contratual, no prazo de até 10 (dez) dias úteis, contados da convocação, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas nos incisos abaixo, no valor de R$ 548.622,18 (quinhentos e quarenta e oito mil, seiscentos e vinte e dois reais e dezoito centavos), correspondente a 5 % (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I.Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas por este; II.Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a)  O Instrumento de Apólice de Seguro deve prever expressamente: 1. responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas à CONTRATADA; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III.Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a)  O Instrumento de Fiança deve prever expressamente: 1. renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; 2. vigência pelo prazo contratual; 3. prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento da CONTRATADA - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_179_2021, clausula_decima_primeira_obrigações_contratada, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DA CONTRATADA', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA: I. manter durante a vigência deste Contrato todas as condições de habilitação e qualificação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir da CONTRATADA a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil – RFB, comprovando ao BNDES, sua exclusão obrigatória do  Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se a CONTRATADA, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das exceções previstas no artigo 17 da Lei Complementar nº 123/2006;  VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos estabelecidos pelo BNDES para a adequada execução do Contrato; IX. designar 1 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor da CONTRATADA, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017; XI. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo a CONTRATADA ser instada a intervir no processo; XII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; e XIII. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência do CONTRATO. XIV. fornecer todas as informações necessárias para a utilização do serviço contratado pelo BNDES (chamado com Prioridade Baixa, conforme a tabela do subitem 19..2.1 das Especificações Técnicas); XV. Manter, durante toda a vigência do Contrato, o escalation list, para o serviço de suporte, atualizado até o nível de direção da empresa (chamado com Prioridade Baixa, conforme a tabela do subitem 19.2.19.2.1 das Especificações Técnicas); XVI. Informar e manter atualizados o CPF e nome completo do preposto da Contratada perante o BNDES (chamado com Prioridade Baixa, conforme a tabela do subitem 19.2.1 das Especificações Técnicas). O preposto deverá comparecer ao BNDES para reuniões presenciais sempre que requerido pelo Gestor do Contrato (chamado com Prioridade Baixa, conforme a tabela do subitem 19.2.1 das Especificações Técnicas); XVII. Assumir inteira responsabilidade técnica e administrativa em relação ao objeto contratado, não podendo, sob qualquer hipótese, transferir a outras empresas a responsabilidade por problemas na prestação dos serviços; XVIII. Manter sigilo relativamente ao objeto contratado, bem como sobre dados, documentos, especificações técnicas ou comerciais, não tornadas públicas pelo BNDES, de que venha a ter conhecimento em virtude da contratação, bem como a respeito da execução e resultados obtidos na prestação de serviços, inclusive após o término do prazo de vigência do CONTRATO, sendo vedada a divulgação dos referidos resultados a terceiros em geral, e em especial a quaisquer meios de comunicação públicos e/ou privados; XIX. Adotar medidas de segurança adequadas, no âmbito das atividades sob seu controle, para a manutenção do sigilo referido no subitem anterior; XX. Não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço; XXI. Devolver, impreterivelmente, ao término do CONTRATO, ou a qualquer tempo a pedido do BNDES, todos os documentos que o BNDES tenha lhe fornecido; XXII. Indicar seus dados de endereço, telefone e endereço de correio eletrônico, mantendo-os atualizados perante o BNDES durante toda a vigência do Contrato (chamado com Prioridade Baixa, conforme a tabela do subitem19.2.1 das Especificações Técnicas); XXIII. Notificar ao BNDES, por escrito, quaisquer fatos que possam pôr em risco a execução do presente objeto; XXIV. Apresentar, por ocasião da formalização do Contrato, o(s) Termo(s) de Confidencialidade, conforme as instruções abaixo: i. Termo de Confidencialidade – Modelo A (Representante Legal), conforme minuta constante do Edital, assinado por seu(s) representante(s) legal(is) de cada vencedora do respectivo Item do Certame, e, no caso de Consórcio, pelo(s) representante(s) legal(is) de cada consorciada. ii. Termo de Confidencialidade – Modelo C (Representante Legal      Subcontratada), conforme minuta constante do Edital, assinado pelo(s) representante(s) legal(is) de cada subcontratada. XXV. Apresentar, antes do início da prestação dos serviços e a cada novo profissional a ser alocado para atendimento ao BNDES, Termo de Confidencialidade – Modelo B (Profissionais), conforme modelo anexados ao Edital, assinado pelos profissionais; XXVI. Prestar todos os esclarecimentos que lhe forem solicitados pelo BNDES (chamado com Prioridade Baixa, conforme a tabela do subitem19.2.1 das Especificações Técnicas); XXVII. Aceitar, por parte do BNDES, em todos os aspectos, a fiscalização no cumprimento do objeto contratado (chamado com Prioridade Baixa, conforme a tabela do subitem 19.2.1 das Especificações Técnicas);  XXVIII. Responder pelos danos comprovadamente causados ao BNDES ou a terceiros, decorrentes de sua culpa ou dolo, quando da execução do objeto contratado. A fiscalização ou o acompanhamento do BNDES não excluirá ou reduzirá essa responsabilidade da Contratada; XXIX. Assegurar durante a execução do objeto desta contratação, a utilização das melhores técnicas para garantir o respeito à privacidade e à proteção de dados pessoais eventualmente nela processados, em conformidade com a legislação, devendo: a) zelar pelas garantias, direitos e deveres, notadamente os previstos na Resolução nº 4.658, de 26 de abril de 2018, do Conselho Monetário Nacional (Política de Segurança Cibernética), na Lei Federal nº 13.709, de 14 de agosto de 2018 (Lei Geral de Proteção de Dados Pessoais - LGPD) e no restante da legislação vigente relativa ao tema; b) promover e cooperar com mecanismos de correção de falhas ocasionadas pelo sistema que possam gerar violação à LGPD, auxiliando, inclusive, na eventual prestação de informações aos órgãos de controle e às autoridades competentes como, por exemplo, a Agência Nacional de Proteção de Dados (ANPD); c) prover mecanismos para preservar o caráter confidencial de informações coletadas, zelando sempre pela proteção dos dados pessoais e do sigilo das informações quando protegidas por lei, nos termos da legislação aplicável; d) informar imediatamente ao BNDES, a partir do momento em que tomar ciência, sobre a ocorrência de falhas ou violações de sistema decorrentes de sua ação ou omissão, bem como de seus empregados, prepostos e prestadores de serviço e/ou qualquer pessoa natural ou jurídica envolvida na execução do objeto contratual, que possam acarretar violação à LGPD.')).
contract_clause(contrato_ocs_179_2021, clausula_decima_segunda_conduta_etica_da_contratada_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES', 'A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_179_2021, clausula_decima_terceira_sigilo_das_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe à CONTRATADA cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação do serviço: I.cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II.não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III.sempre que tiver acesso às informações mencionadas no Inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação do serviço objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar imediatamente ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV.entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V.apresentar, antes do início da prestação do serviço, Termos de Confidencialidade, conforme modelo anexo a este Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI.observar o disposto no Termo de Confidencialidade assinado por seus representantes legais, anexo a este Contrato.').
contract_clause(contrato_ocs_179_2021, clausula_decima_quarta_obrigações_do_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Renato Soffiatti, que atualmente exerce a função de Coordenador de Serviços da ATI/DESET/GINF, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA; IV. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VI. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_179_2021, clausula_decima_quinta_cessão_de_contrato_ou_de_crédito_sucessão_contratual_e_subcontratação, 'CLÁUSULA DÉCIMA QUINTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', ' É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro  É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Edital.   Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É admitida a subcontratação da parcela do objeto deste Contrato nos termos do item 18 do Termo de Referência, condicionada à aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal operação.  Parágrafo Quarto Caso a CONTRATADA opte por subcontratar o objeto deste Contrato, permanecerá como responsável perante o BNDES pela adequada execução do ajuste, sujeitando-se, inclusive, às penalidades previstas neste Contrato, na hipótese de não cumprir as obrigações ora pactuadas, ainda que por culpa da SUBCONTRATADA.  Parágrafo Quinto Aceita, pelo BNDES, a subcontratação, a CONTRATADA deverá apresentar os Termos de Confidencialidade, conforme modelos anexos a este Contrato, assinados pelo representante legal da SUBCONTRATADA.').
contract_clause(contrato_ocs_179_2021, clausula_decima_sexta_penalidades, 'CLÁUSULA DÉCIMA SEXTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às seguintes penalidades: I. advertência; II. multa: a)  Multa de até 20% (vinte por cento) sobre a parcela contratual descumprida, a         critério da autoridade competente do BNDES, caso o descumprimento dos prazos de nível de serviço estabelecidos enseje ajustes de pagamento superiores aos limites previstos para descontos; b) Multa de até 10% (dez por cento) sobre o valor global do Contrato, a critério da autoridade competente do BNDES, em razão de qualquer descumprimento das demais obrigações contratuais, não previstas nos itens acima. III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.    Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades e estará limitada a 30% (trinta por cento) do valor global do Contrato.  Parágrafo Quinto A multa aplicada à CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_179_2021, clausula_decima_setima_alterações_contratuais, 'CLÁUSULA DÉCIMA SÉTIMA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_179_2021, clausula_decima_oitava_extinção_do_contrato, 'CLÁUSULA DÉCIMA OITAVA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; IV. quando for decretada a falência da CONTRATADA; V. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pela CONTRATADA no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução / do falecimento] da CONTRATADA; e XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_179_2021, clausula_decima_nona_acesso_e_protecao_de_dados_pessoais, 'CLÁUSULA DÉCIMA NONA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade e o livre desenvolvimento da personalidade da pessoa natural, relativos ao tratamento de dados pessoais, inclusive nos meios digitais, devendo, para tanto, adotar medidas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:    I. eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II. o tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispensa tal medida;  III. os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia instrução do BNDES, ou por ordem judicial, observando-se as medidas legalmente previstas para tanto;  IV. os dados deverão ser armazenados pelo CONTRATADO que utilizará recursos de segurança da informação e tecnologia seguros, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos  V. o CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  VI. O CONTRATADO deverá disponibilizar ao titular do dado canal em que seja garantida consulta facilitada e gratuita sobre a forma e a duração do tratamento e a integralidade de seus dados pessoais.  VII. o CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  VIII. o CONTRATADO deverá manter registro das operações de tratamento de dados pessoais que realizar, disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do relatório de impacto indicado na LGPD.  IX. qualquer incidente que implique em violação ou risco de violação de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  X. ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”.   Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras da lei geral de proteção de dados, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018.').
contract_clause(contrato_ocs_179_2021, clausula_vigesima_disposições_finais, 'CLÁUSULA VIGÉSIMA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.    Parágrafo Primeiro Integram este Contrato, o Termo de Referência, a Proposta da CONTRATADA, a Matriz de Riscos, e os Termos de Confidencialidade, respectivamente, Anexos I, II, III e IV ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_179_2021, clausula_vigesima_primeira_foro, 'CLÁUSULA VIGÉSIMA PRIMEIRA– FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato são conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, apenas para a conferência de sua redação, por autorização do representante legal que o assina.  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a última assinatura dos representantes legais do BNDES.    Rio de Janeiro, 26 de agosto de 2021.     _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     _____________________________________________________________________ ZIVA TECNOLOGIA E SOLUÇÕES LTDA    Testemunhas:   _________________________________ _________________________________ Nome/CPF: Nome/CPF:   ANTONIO DONIZETE GOMES DA SILVA:09334778806Assinado de forma digital por ANTONIO DONIZETE GOMES DA SILVA:09334778806 Dados: 2021.08.27 09:55:18 -03\'00\'HERILMAR POMPERMAYER FREIRE:00181257785Assinado de forma digital por HERILMAR POMPERMAYER FREIRE:00181257785 Dados: 2021.08.30 18:54:52 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2021.08.31 10:30:48 -03\'00\'EMMANUEL COUTO SILVA:01320487440Assinado de forma digital por EMMANUEL COUTO SILVA:01320487440 Dados: 2021.08.31 14:42:48 -03\'00\'FLAVIA DUARTE CUPELLO:89164687791Assinado de forma digital por FLAVIA DUARTE CUPELLO:89164687791 Dados: 2021.09.01 17:36:54 -03\'00\'.')

% ===== END =====
